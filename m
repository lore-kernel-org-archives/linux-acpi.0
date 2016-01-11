From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH v3] memory-hotplug: add automatic onlining policy for
 the newly added memory
Date: Mon, 11 Jan 2016 11:01:18 +0000
Message-ID: <56938B7E.3060902@citrix.com>
References: <1452187421-15747-1-git-send-email-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1452187421-15747-1-git-send-email-vkuznets@redhat.com>
Sender: owner-linux-mm@kvack.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Kiper <daniel.kiper@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Tang Chen <tangchen@cn.fujitsu.com>, David
 Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Xishi Qiu <qiuxishi@huawei.com>, Mel Gorman <mgorman@techsingularity.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Igor Mammedov <imammedo@redhat.com>, Kay Sievers <kay@vrfy.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-acpi@vger.kernel.org

On 07/01/16 17:23, Vitaly Kuznetsov wrote:
> 
> - Changes since 'v1':
>   Add 'online' parameter to add_memory_resource() as it is being used by
>   xen ballon driver and it adds "empty" memory pages [David Vrabel].
>   (I don't completely understand what prevents manual onlining in this
>    case as we still have all newly added blocks in sysfs ... this is the
>    discussion point.)

I'm not sure what you're not understanding here?

Memory added by the Xen balloon driver (whether populated with real
memory or not) does need to be onlined by udev or similar.

David

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
