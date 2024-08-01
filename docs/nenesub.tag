<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile doxygen_version="1.9.8">
  <compound kind="file">
    <name>nenesub.hpp</name>
    <path>nenesub/</path>
    <filename>nenesub_8hpp.html</filename>
    <class kind="struct">nenesub::Options</class>
    <namespace>nenesub</namespace>
  </compound>
  <compound kind="struct">
    <name>nenesub::Options</name>
    <filename>structnenesub_1_1Options.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>num_neighbors</name>
      <anchorfile>structnenesub_1_1Options.html</anchorfile>
      <anchor>a5df6fdc7c00d5560cf24e707c6d2a318</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>min_remaining</name>
      <anchorfile>structnenesub_1_1Options.html</anchorfile>
      <anchor>aca8e07989de02b7fc173848333a93695</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>num_threads</name>
      <anchorfile>structnenesub_1_1Options.html</anchorfile>
      <anchor>a97589522562c135c803914e6e4abdecc</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="namespace">
    <name>nenesub</name>
    <filename>namespacenenesub.html</filename>
    <class kind="struct">nenesub::Options</class>
    <member kind="function">
      <type>void</type>
      <name>compute</name>
      <anchorfile>namespacenenesub.html</anchorfile>
      <anchor>a38e855459f3bf52b4248a40e73a27129</anchor>
      <arglist>(Index_ num_obs, GetNeighbors_ get_neighbors, GetIndex_ get_index, GetMaxDistance_ get_max_distance, const Options &amp;options, std::vector&lt; Index_ &gt; &amp;selected)</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; Index_ &gt;</type>
      <name>compute</name>
      <anchorfile>namespacenenesub.html</anchorfile>
      <anchor>a0f8fc59d26d84d5726dd8fe0b845c690</anchor>
      <arglist>(const knncolle::NeighborList&lt; Index_, Distance_ &gt; &amp;neighbors, const Options &amp;options)</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; Index_ &gt;</type>
      <name>compute</name>
      <anchorfile>namespacenenesub.html</anchorfile>
      <anchor>a9690e9944c27045dfed80989191fc842</anchor>
      <arglist>(const knncolle::Prebuilt&lt; Dim_, Index_, Float_ &gt; &amp;prebuilt, const Options &amp;options)</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; Index_ &gt;</type>
      <name>compute</name>
      <anchorfile>namespacenenesub.html</anchorfile>
      <anchor>a19b97f1e543d9932e4a31d6ade6acb51</anchor>
      <arglist>(Dim_ num_dims, Index_ num_obs, const Value_ *data, const knncolle::Builder&lt; knncolle::SimpleMatrix&lt; Dim_, Index_, Value_ &gt;, Float_ &gt; &amp;knn_method, const Options &amp;options)</arglist>
    </member>
  </compound>
  <compound kind="page">
    <name>index</name>
    <title>Nearest-neighbors subsampling</title>
    <filename>index.html</filename>
    <docanchor file="index.html">md__2github_2workspace_2README</docanchor>
  </compound>
</tagfile>
