From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Date: Sat, 1 Sep 2018 16:03:58 +0200
Message-ID: <d4b6608b-0b21-b925-4adc-d11e4706f69d@redhat.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180831205457.GB3945@techadventures.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180831205457.GB3945@techadventures.net>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Oscar Salvador <osalvador@techadventures.net>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil
List-Id: linux-acpi@vger.kernel.org

On 31.08.2018 22:54, Oscar Salvador wrote:
> On Tue, Aug 21, 2018 at 12:44:12PM +0200, David Hildenbrand wrote:
>> This is the same approach as in the first RFC, but this time without
>> exporting device_hotplug_lock (requested by Greg) and with some more
>> details and documentation regarding locking. Tested only on x86 so far.
> 
> Hi David,
> 
> I would like to review this but I am on vacation, so I will not be able to get to it
> soon.
> I plan to do it once I am back.

Sure, I won't be resending within next two weeks either way, as I am
also on vacation.

Have a nice vacation!

> 
> Thanks
> 


-- 

Thanks,

David / dhildenb
