From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: [PATCH] Don't save state in ACPI on shutdown/reboot]
Date: Thu, 13 Nov 2003 00:07:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031112230756.GD32464@poupinou.org>
References: <1068567824.24982.21.camel@dhcppc4> <20031111170035.GD29175@poupinou.org> <20031112220559.GR31026@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031112220559.GR31026-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ak-h9bWGtP8wOw@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 12, 2003 at 10:05:59PM +0000, Dave Jones wrote:
> On Tue, Nov 11, 2003 at 06:00:35PM +0100, Ducrot Bruno wrote:
> 
>  > > The ACPI code in 2.4 currently saves the machine state as for a 
>  > > suspend when doing an reboot or shutdown. This fails on x86-64
>  > > on some boxes.
>  > > 
>  > > Don't save/restore state in ACPI when entering S5.
>  > 
>  > That break also some i386 boxes.  That why I submitted another patch (do
>  > I have to post it again?)
> 
> Do you mean Andi's patch breaks i386 boxes, or this bug also appears
> on i386 ? The former seems unlikely from the look of Andi's patch.
> 

I wanted to point that some i386 boxes are broken as well, and
then a patch is needed.  And yes, when I read again my email, that
a bit confusing.

The patch I send actually implement the exact same
behaviour of 2.6 (minus S5 via the proc file, disabled on 2.6).

Also, it is much likely a design fix.  'power off' shall not
be dependant of CONFIG_ACPI_SLEEP (even though than one is always
yes for 2.4 if CONFIG_ACPI, at least on i386).

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
