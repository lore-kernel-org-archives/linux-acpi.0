From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 1/7] x86, memhp, numa: Online memory-less nodes at boot
 time.
Date: Wed, 20 Jul 2016 09:52:56 +0800
Message-ID: <dcce26e9-bd9f-e9db-b1c7-6a18271395f2@cn.fujitsu.com>
References: <1468913288-16605-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1468913288-16605-2-git-send-email-douly.fnst@cn.fujitsu.com>
 <20160719185017.GM3078@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------E4C35AA4269377E76DF27B3E"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160719185017.GM3078@mtj.duckdns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: cl@linux.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Tang Chen <tangchen@cn.fujitsu.com>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

--------------E4C35AA4269377E76DF27B3E
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2016=E5=B9=B407=E6=9C=8820=E6=97=A5 02:50, Tejun Heo =E5=86=99=E9=
=81=93:
> Hello,
>
> On Tue, Jul 19, 2016 at 03:28:02PM +0800, Dou Liyang wrote:
>> In this series of patches, we are going to construct cpu <-> node mapp=
ing
>> for all possible cpus at boot time, which is a 1-1 mapping. It means t=
he
> 1-1 mapping means that each cpu is mapped to its own private node
> which isn't the case.  Just call it a persistent mapping?

Yes, each cpu is just in a persistent node.
However, the opposite is not true.

I will modify it.


>
>> cpu will be mapped to the node it belongs to, and will never be change=
d.
>> If a node has only cpus but no memory, the cpus on it will be mapped t=
o
>> a memory-less node. And the memory-less node should be onlined.
>>
>> This patch allocate pgdats for all memory-less nodes and online them a=
t
>> boot time. Then build zonelists for these nodes. As a result, when cpu=
s
>> on these memory-less nodes try to allocate memory from local node, it
>> will automatically fall back to the proper zones in the zonelists.
> Yeah, I think this is an a lot better approach for memory-less nodes.
>
>> Signed-off-by: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>

Thanks,

Dou





--------------E4C35AA4269377E76DF27B3E
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p><br>
    </p>
    <br>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2016=E5=B9=B407=E6=9C=8820=E6=
=97=A5 02:50, Tejun Heo =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote cite=3D"mid:20160719185017.GM3078@mtj.duckdns.org"
      type=3D"cite">
      <pre wrap=3D"">Hello,

On Tue, Jul 19, 2016 at 03:28:02PM +0800, Dou Liyang wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">In this series of patches, we are going to constru=
ct cpu &lt;-&gt; node mapping
for all possible cpus at boot time, which is a 1-1 mapping. It means the
</pre>
      </blockquote>
      <pre wrap=3D"">
1-1 mapping means that each cpu is mapped to its own private node
which isn't the case.  Just call it a persistent mapping?</pre>
    </blockquote>
    <pre>
Yes, each cpu is just in a persistent node.
<span class=3D"" id=3D"w_11" high-light-id=3D"w_0,w_11">However</span><sp=
an class=3D"" id=3D"w_12" high-light-id=3D"w_1,w_12">, </span><span id=3D=
"w_13" high-light-id=3D"">the </span><span id=3D"w_14" high-light-id=3D"w=
_2,w_14" class=3D"high-light">opposite </span><span class=3D"" id=3D"w_15=
" high-light-id=3D"w_3,w_15">is </span><span class=3D"" id=3D"w_16" high-=
light-id=3D"w_4,w_16">not </span><span id=3D"w_17" high-light-id=3D"w_7,w=
_17" class=3D"high-light">true</span><span class=3D"" id=3D"w_20" high-li=
ght-id=3D"w_9,w_20"></span><span class=3D"" id=3D"w_21" high-light-id=3D"=
w_10,w_21">. </span>

I will modify it.</pre>
    <br>
    <blockquote cite=3D"mid:20160719185017.GM3078@mtj.duckdns.org"
      type=3D"cite">
      <pre wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">cpu will be mapped to the node it belongs to, and =
will never be changed.
If a node has only cpus but no memory, the cpus on it will be mapped to
a memory-less node. And the memory-less node should be onlined.

This patch allocate pgdats for all memory-less nodes and online them at
boot time. Then build zonelists for these nodes. As a result, when cpus
on these memory-less nodes try to allocate memory from local node, it
will automatically fall back to the proper zones in the zonelists.
</pre>
      </blockquote>
      <pre wrap=3D"">
Yeah, I think this is an a lot better approach for memory-less nodes.

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Signed-off-by: Zhu Guihua <a class=3D"moz-txt-link=
-rfc2396E" href=3D"mailto:zhugh.fnst@cn.fujitsu.com">&lt;zhugh.fnst@cn.fu=
jitsu.com&gt;</a>
</pre>
      </blockquote>
    </blockquote>
    <pre>
Thanks,

Dou
</pre>
    <br>
  </body>
</html>

--------------E4C35AA4269377E76DF27B3E--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
