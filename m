From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 1/5] x86, gfp: Cache best near node for memory allocation.
Date: Tue, 4 Aug 2015 16:58:47 +0800
Message-ID: <55C07EC7.3040301@cn.fujitsu.com>
References: <1436261425-29881-1-git-send-email-tangchen@cn.fujitsu.com>, 	<1436261425-29881-2-git-send-email-tangchen@cn.fujitsu.com>, 	<20150715214802.GL15934@mtj.duckdns.org>, 	<55C03332.2030808@cn.fujitsu.com> <201508041626380745999@inspur.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------080805040207090808020608"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <201508041626380745999@inspur.com>
Sender: owner-linux-mm@kvack.org
To: "gongzhaogang@inspur.com" <gongzhaogang@inspur.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "hpa@zytor.com" <hpa@zytor.com>, tangchen@cn.fujitsu.com, "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "kamezawa.hiroyu@jp.fujitsu.com" <kamezawa.hiroyu@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "qiaonuohan@cn.fujitsu.com" <qiaonuohan@cn.fujitsu.com>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-acpi@vger.kernel.org

--------------080805040207090808020608
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


On 08/04/2015 04:26 PM, gongzhaogang@inspur.com wrote:
> Sorry,I am new.
> >But,
> >1) in cpu_up(), it will try to online a node, and it doesn't check if
> >the node has memory.
> >2) in try_offline_node(), it offlines CPUs first, and then the memory.
> >This behavior looks a little wired, or let's say it is ambiguous. It
> >seems that a NUMA node
> >consists of CPUs and memory. So if the CPUs are online, the node should
> >be online.
> I suggested you to try the patch offered by Liu Jiang.
>
> https://lkml.org/lkml/2014/9/11/1087
>

Well, I think Liu Jiang meant this patch set. :)

https://lkml.org/lkml/2014/7/11/75

> I have tried ,It is OK.
>
> >Unfortunately, since I don't have a machine a with memory-less node, I
> >cannot reproduce
> >the problem right now.
>
> If  not hurried  , I can test your patches in our environment on weekends.
>
Thanks. But this version of my patch set is obviously problematic.
It will be very nice of you if you can help to test the next version.
But maybe in a few days.

Thanks. :)

--------------080805040207090808020608
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 08/04/2015 04:26 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:gongzhaogang@inspur.com">gongzhaogang@inspur.com</a> wrote:<br>
    </div>
    <blockquote cite="mid:201508041626380745999@inspur.com" type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <style>body { line-height: 1.5; }blockquote { margin-top: 0px; margin-bottom: 0px; margin-left: 0.5em; }body { font-size: 10.5pt; font-family: ????; color: rgb(0, 0, 0); line-height: 1.5; }</style>
      <div><span></span>Sorry,I am new.</div>
      <div>
        <div>&gt;But,</div>
        <div>&gt;1) in cpu_up(), it will try to online a node, and it
          doesn't check if</div>
        <div>&gt;the node has memory.</div>
        <div>&gt;2) in try_offline_node(), it offlines CPUs first, and
          then the memory.</div>
        <div>&nbsp;</div>
        <div>&gt;This behavior looks a little wired, or let's say it is
          ambiguous. It</div>
        <div>&gt;seems that a NUMA node</div>
        <div>&gt;consists of CPUs and memory. So if the CPUs are online,
          the node should</div>
        <div>&gt;be online.</div>
      </div>
      <div>I suggested you to try the patch offered by Liu Jiang.</div>
      <div><br>
      </div>
      <div><span style="background-color: rgba(0, 0, 0, 0); font-size:
          10.5pt; line-height: 1.5;"><a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2014/9/11/1087">https://lkml.org/lkml/2014/9/11/1087</a></span>&nbsp;</div>
      <div><br>
      </div>
    </blockquote>
    <br>
    Well, I think Liu Jiang meant this patch set. :)<br>
    <br>
    <a class="moz-txt-link-freetext"
      href="https://lkml.org/lkml/2014/7/11/75">https://lkml.org/lkml/2014/7/11/75</a><br>
    <br>
    <blockquote cite="mid:201508041626380745999@inspur.com" type="cite">
      <div>I have tried ,It is OK.</div>
      <div><br>
      </div>
      <div>
        <div>&gt;Unfortunately, since I don't have a machine a with
          memory-less node, I</div>
        <div>&gt;cannot reproduce</div>
        <div>&gt;the problem right now.</div>
      </div>
      <div><br>
      </div>
      <div>If &nbsp;not hurried &nbsp;, I can test your patches in our environment
        on weekends.</div>
      <br>
    </blockquote>
    Thanks. But this version of my patch set is obviously problematic. <br>
    It will be very nice of you if you can help to test the next
    version.<br>
    But maybe in a few days.<br>
    <br>
    Thanks. :)<br>
  </body>
</html>

--------------080805040207090808020608--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
