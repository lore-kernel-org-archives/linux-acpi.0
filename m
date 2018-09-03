From: Rashmica <rashmica.g@gmail.com>
Subject: [PATCH RFCv2 3/6] mm/memory_hotplug: fix
 online/offline_pages called w.o. mem_hotplug_lock
Date: Mon, 3 Sep 2018 10:36:24 +1000
Message-ID: <70372ef5-e332-6c07-f08c-50f8808bde6d@gmail.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-4-david@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7033227392406503336=="
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20180821104418.12710-4-david@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dan Williams <dan.j.williams@intel.com>, YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>, Math
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--===============7033227392406503336==
Content-Type: multipart/alternative;
 boundary="------------1093E43F969F497286F217F7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1093E43F969F497286F217F7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi David,


On 21/08/18 20:44, David Hildenbrand wrote:

> There seem to be some problems as result of 30467e0b3be ("mm, hotplug:
> fix concurrent memory hot-add deadlock"), which tried to fix a possible
> lock inversion reported and discussed in [1] due to the two locks
> 	a) device_lock()
> 	b) mem_hotplug_lock
>
> While add_memory() first takes b), followed by a) during
> bus_probe_device(), onlining of memory from user space first took b),
> followed by a), exposing a possible deadlock.

Do you mean "onlining of memory from user space first took a),
followed by b)"? 

> In [1], and it was decided to not make use of device_hotplug_lock, but
> rather to enforce a locking order.
>
> The problems I spotted related to this:
>
> 1. Memory block device attributes: While .state first calls
>    mem_hotplug_begin() and the calls device_online() - which takes
>    device_lock() - .online does no longer call mem_hotplug_begin(), so
>    effectively calls online_pages() without mem_hotplug_lock.
>
> 2. device_online() should be called under device_hotplug_lock, however
>    onlining memory during add_memory() does not take care of that.
>
> In addition, I think there is also something wrong about the locking in
>
> 3. arch/powerpc/platforms/powernv/memtrace.c calls offline_pages()
>    without locks. This was introduced after 30467e0b3be. And skimming over
>    the code, I assume it could need some more care in regards to locking
>    (e.g. device_online() called without device_hotplug_lock - but I'll
>    not touch that for now).

Can you mention that you fixed this in later patches?


The series looks good to me. Feel free to add my reviewed-by:

Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>


--------------1093E43F969F497286F217F7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <pre>Hi David,


On 21/08/18 20:44, David Hildenbrand wrote:</pre>
    </div>
    <blockquote type="cite"
      cite="mid:20180821104418.12710-4-david@redhat.com">
      <pre wrap="">There seem to be some problems as result of 30467e0b3be ("mm, hotplug:
fix concurrent memory hot-add deadlock"), which tried to fix a possible
lock inversion reported and discussed in [1] due to the two locks
	a) device_lock()
	b) mem_hotplug_lock

While add_memory() first takes b), followed by a) during
bus_probe_device(), onlining of memory from user space first took b),
followed by a), exposing a possible deadlock.</pre>
    </blockquote>
    <pre>Do you mean "onlining of memory from user space first took a),
followed by b)"? 

</pre>
    <blockquote type="cite"
      cite="mid:20180821104418.12710-4-david@redhat.com">
      <pre wrap="">
In [1], and it was decided to not make use of device_hotplug_lock, but
rather to enforce a locking order.

The problems I spotted related to this:

1. Memory block device attributes: While .state first calls
   mem_hotplug_begin() and the calls device_online() - which takes
   device_lock() - .online does no longer call mem_hotplug_begin(), so
   effectively calls online_pages() without mem_hotplug_lock.

2. device_online() should be called under device_hotplug_lock, however
   onlining memory during add_memory() does not take care of that.

In addition, I think there is also something wrong about the locking in

3. arch/powerpc/platforms/powernv/memtrace.c calls offline_pages()
   without locks. This was introduced after 30467e0b3be. And skimming over
   the code, I assume it could need some more care in regards to locking
   (e.g. device_online() called without device_hotplug_lock - but I'll
   not touch that for now).</pre>
    </blockquote>
    <pre>Can you mention that you fixed this in later patches?

</pre>
    <br>
    <pre>The series looks good to me. Feel free to add my reviewed-by:

Reviewed-by: Rashmica Gupta <a class="moz-txt-link-rfc2396E" href="mailto:rashmica.g@gmail.com">&lt;rashmica.g@gmail.com&gt;</a></pre>
  </body>
</html>

--------------1093E43F969F497286F217F7--


--===============7033227392406503336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVs
IG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0
cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA==

--===============7033227392406503336==--
