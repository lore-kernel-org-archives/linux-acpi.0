From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH/RFC 1/4]device core changes
Date: Wed, 10 Nov 2004 09:45:37 +0800
Message-ID: <1100051137.7825.6.camel@sli10-desk.sh.intel.com>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
	 <20041108225810.GB16197@kroah.com>
	 <1099961418.15294.11.camel@sli10-desk.sh.intel.com>
	 <1099971341.15294.48.camel@sli10-desk.sh.intel.com>
	 <20041109045843.GA4849@kroah.com>
	 <1099990981.15294.57.camel@sli10-desk.sh.intel.com>
	 <20041110012443.GA9496@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041110012443.GA9496-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-11-10 at 09:24, Greg KH wrote:
> > > 
> > > Hm, hopefully Pat will chime in about what would be best for this, as he
> > > created the platform_notify interface.
> > Ok, an updated version. Use 'platform_notify', but add a 'type' in 
> > 'struct bus_type'. Using bus_type->name to identify the bus type is
> > pretty much ugly and slow. 
> 
> No, no "type" for a bus, sorry.
> 
> Maybe your other patches weren't so bad...  If we implement them, can we
> drop the platform notify stuff?
Currently only ARM use 'platform_notify', and we can easily convert it
to use per-bus 'platform_bind'. One concern of per-bus 'platform_bind'
is we will have many '#ifdef ..' if many platforms implement their
per-bus 'platform_bind'.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
