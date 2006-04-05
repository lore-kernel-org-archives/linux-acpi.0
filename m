From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [patch 22/26] acpi memory hotplug cannot manage _CRS with
 plural resoureces
Date: Wed, 5 Apr 2006 09:24:08 +0900
Message-ID: <20060405092408.a62870c2.kamezawa.hiroyu@jp.fujitsu.com>
References: <971FCB6690CD0E4898387DBF7552B90E04E7BBE3@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63142 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751031AbWDEAWW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Apr 2006 20:22:22 -0400
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E04E7BBE3@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, len.brown@intel.com, akpm@osdl.org, linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com

On Tue, 4 Apr 2006 13:16:50 -0700
"Moore, Robert" <robert.moore@intel.com> wrote:

> Sorry, you should use acpi_os_free()
> 
Okay, Thank you

-Kame


> 
> 
> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Monday, April 03, 2006 10:34 AM
> > To: 'KAMEZAWA Hiroyuki'; Brown, Len
> > Cc: akpm@osdl.org; linux-acpi@vger.kernel.org;
> > kaneshige.kenji@jp.fujitsu.com
> > Subject: RE: [patch 22/26] acpi memory hotplug cannot manage _CRS with
> > plural resoureces
> > 
> > > BTW, For freeing buffer.pointer (returned by acpi_get_object_info
> etc.),
> > > should I also use kfree() ?
> > >
> > 
> > For that (memory that was originally allocated by the acpica core),
> you
> > should use the ACPI_FREE macro.
> > 
> > Bob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

