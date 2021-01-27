defmodule NewsApiClient do
  @moduledoc """
  Documentation for `NewsApiClient`.
  """

  @base_url "https://newsapi.org/v2/"

  @doc """
  This endpoint provides live top and breaking headlines for a country, specific category in a country, single source, or multiple sources. You can also search with keywords. Articles are sorted by the earliest date published first.This endpoint is great for retrieving headlines for display on news tickers or similar.

  ##Request parameters

  country
  The 2-letter ISO 3166-1 code of the country you want to get headlines for. Possible options: ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za . Note: you can't mix this param with the sources param.

  category
  The category you want to get headlines for. Possible options: business entertainment general health science sports technology . Note: you can't mix this param with the sources param.

  sources
  A comma-seperated string of identifiers for the news sources or blogs you want headlines from. Use the /sources endpoint to locate these programmatically or look at the sources index. Note: you can't mix this param with the country or category params.

  q
  Keywords or a phrase to search for.

  pageSize
  int
  The number of results to return per page (request). 20 is the default, 100 is the maximum.

  page
  int
  Use this to page through the results if the total results found is greater than the page size.

  apiKey
  REQUIRED
  Your API key. Alternatively you can provide this via the X-Api-Key HTTP header.

  ##Response object

  status
  string
  If the request was successful or not. Options: ok, error. In the case of error a code and message property will be populated.

  totalResults
  int
  The total number of results available for your request.

  articles
  array[article]
  The results of the request.

  source
  object
  The identifier id and a display name name for the source this article came from.

  author
  string
  The author of the article

  title
  string
  The headline or title of the article.

  description
  string
  A description or snippet from the article.

  url
  string
  The direct URL to the article.

  urlToImage
  string
  The URL to a relevant image for the article.

  publishedAt
  string
  The date and time that the article was published, in UTC (+000)

  content
  string
  The unformatted content of the article, where available. This is truncated to 200 chars.
  """
  def top_headlines(params \\ %{"pageSize" => "100", "country" => "us", "categories" => "science"}, api_key \\ System.get_env("NEWS_API_KEY")) do
    query_params = URI.encode_query(params)
    headers = ["Authorization": "Bearer #{api_key}", "Accept": "Application/json; Charset=utf-8"]
    {:ok, response} = HTTPoison.get(@base_url <> "top-headlines?" <> query_params, headers)
    Poison.decode!(response.body)
  end

  @doc """
  Search through millions of articles from over 50,000 large and small news sources and blogs. This includes breaking news as well as lesser articles. This endpoint suits article discovery and analysis, but can be used to retrieve articles for display, too.

  ##Request parameters
  q
  Keywords or phrases to search for in the article title and body.

  Advanced search is supported here:

  Surround phrases with quotes (") for exact match.
  Prepend words or phrases that must appear with a + symbol. Eg: +bitcoin
  Prepend words that must not appear with a - symbol. Eg: -bitcoin
  Alternatively you can use the AND / OR / NOT keywords, and optionally group these with parenthesis. Eg: crypto AND (ethereum OR litecoin) NOT bitcoin.
  The complete value for q must be URL-encoded.

  qInTitle
  Keywords or phrases to search for in the article title only.

  Advanced search is supported here:

  Surround phrases with quotes (") for exact match.
  Prepend words or phrases that must appear with a + symbol. Eg: +bitcoin
  Prepend words that must not appear with a - symbol. Eg: -bitcoin
  Alternatively you can use the AND / OR / NOT keywords, and optionally group these with parenthesis. Eg: crypto AND (ethereum OR litecoin) NOT bitcoin.
  The complete value for qInTitle must be URL-encoded.

  sources
  A comma-seperated string of identifiers (maximum 20) for the news sources or blogs you want headlines from. Use the /sources endpoint to locate these programmatically or look at the sources index.

  domains
  A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to restrict the search to.

  excludeDomains
  A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to remove from the results.

  from
  A date and optional time for the oldest article allowed. This should be in ISO 8601 format (e.g. 2021-01-27 or 2021-01-27T03:52:13) Default: the oldest according to your plan.

  to
  A date and optional time for the newest article allowed. This should be in ISO 8601 format (e.g. 2021-01-27 or 2021-01-27T03:52:13) Default: the newest according to your plan.

  language
  The 2-letter ISO-639-1 code of the language you want to get headlines for. Possible options: ardeenesfrheitnlnoptruseudzh. Default: all languages returned.

  sortBy
  The order to sort the articles in. Possible options: relevancy, popularity, publishedAt.
  relevancy = articles more closely related to q come first.
  popularity = articles from popular sources and publishers come first.
  publishedAt = newest articles come first.
  Default: publishedAt

  pageSize
  int
  The number of results to return per page. 20 is the default, 100 is the maximum.

  page
  int
  Use this to page through the results.

  apiKey
  REQUIRED
  Your API key. Alternatively you can provide this via the X-Api-Key HTTP header.

  ##Response object

  status
  string
  If the request was successful or not. Options: ok, error. In the case of error a code and message property will be populated.

  totalResults
  int
  The total number of results available for your request. Only a limited number are shown at a time though, so use the page parameter in your requests to page through them.

  articles
  array[article]
  The results of the request.

  source
  object
  The identifier id and a display name name for the source this article came from.

  author
  string
  The author of the article

  title
  string
  The headline or title of the article.

  description
  string
  A description or snippet from the article.

  url
  string
  The direct URL to the article.

  urlToImage
  string
  The URL to a relevant image for the article.

  publishedAt
  string
  The date and time that the article was published, in UTC (+000)

  content
  string
  The unformatted content of the article, where available. This is truncated to 200 chars.
  """
  def everything(params \\ %{"q" => "science"}, api_key \\ System.get_env("NEWS_API_KEY")) do
    query_params = URI.encode_query(params)
    headers = ["Authorization": "Bearer #{api_key}", "Accept": "Application/json; Charset=utf-8"]
    {:ok, response} = HTTPoison.get(@base_url <> "everything?" <> query_params, headers)
    Poison.decode!(response.body)
  end

  @doc """
  This endpoint returns the subset of news publishers that top headlines (/v2/top-headlines) are available from. It's mainly a convenience endpoint that you can use to keep track of the publishers available on the API, and you can pipe it straight through to your users.

  ##Request parameters

  category
  Find sources that display news of this category. Possible options: business entertainment general health science sports technology . Default: all categories.

  language
  Find sources that display news in a specific language. Possible options: ar de en es fr he it nl no pt ru se ud zh . Default: all languages.

  country
  Find sources that display news in a specific country. Possible options: ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za . Default: all countries.

  apiKey
  REQUIRED
  Your API key. Alternatively you can provide this via the X-Api-Key HTTP header.

  ##Response object

  status
  string
  If the request was successful or not. Options: ok, error. In the case of error a code and message property will be populated.

  sources
  array[source]
  The results of the request.

  id
  string
  The identifier of the news source. You can use this with our other endpoints.

  name
  string
  The name of the news source

  description
  string
  A description of the news source

  url
  string
  The URL of the homepage.

  category
  string
  The type of news to expect from this news source.

  language
  string
  The language that this news source writes in.

  country
  string
  The country this news source is based in (and primarily writes about).
  """

  def sources(params \\ %{}, api_key \\ System.get_env("NEWS_API_KEY")) do
    query_params = URI.encode_query(params)
    headers = ["Authorization": "Bearer #{api_key}", "Accept": "Application/json; Charset=utf-8"]
    {:ok, response} = HTTPoison.get(@base_url <> "sources?" <> query_params, headers)
    Poison.decode!(response.body)
  end

  def sources_list(params \\ %{}) do
    sources_map = sources(params)
    Enum.map(sources_map["sources"], fn x -> x["id"] end)
  end
end
