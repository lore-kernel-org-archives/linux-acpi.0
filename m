From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Wed, 16 Feb 2005 20:40:17 +0100
Message-ID: <20050216194017.GQ1145@poupinou.org>
References: <20050210161809.GK3493@crusoe.alcove-fr> <1108481448.2097.71.camel@d845pe> <20050215153912.GA3523@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215153912.GA3523-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > platform specific wart is the only way to go.  But
> > it would be best if we can make the exotic Sony/SNC
> > look more generic to the user so that the user
> > (and the distro supporting them) don't need to learn
> > special things to handle this system.
> 
> I agree, but unfortunately I don't think it's possible to handle
> them in a generic way. However, my understanding of the ACPI layer
> is limited, so I very well be wrong.
> 
> I attached two DSDT in bugzilla, I have a few more if you want them.
> 

I will (re)work some part of the acpi_video stuff in order to make it
more generic (its design is to separate a kind of 'video bus', then
'video devices' can attach.  For now, its support only one kind of device,
the acpi one.  See acpi_viedo.c).  The original goal was to atleast
attach others acpi specific drivers (the toshiba at that time).

Problem though is my time which unfortunately is missing currently
(professional stuff, other free projects and even real life) and
I must admit I don't intend to work on acpi_video right now.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
