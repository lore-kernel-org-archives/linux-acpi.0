From: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: DPMS with ACPI
Date: Sun, 8 Dec 2002 15:54:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212081554.39277.jbr.1@gmx.net>
References: <20021207171140.363b2276.gigerstyle@gmx.ch> <20021207165727.17f6222a.taw27@cam.ac.uk> <20021207182449.602ce242.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021207182449.602ce242.gigerstyle-OI3hZJvNYWs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org>, Thomas White <taw27-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I Don't think that DPMS is really related to APM or ACPI. I cannot use ACPI on 
my desktop pc and I have a nVidia card using the XFree module provided by 
nVidia. APM gets disabled by this module:

kernel: apm: set display: Power management disabled

Nevertheless, "xset dpms force standby" is working properly without any 
Problems.
Perhaps DPMS is supported by APM, ACPI and/or the XFree modules...

Jochen

Am Samstag, 7. Dezember 2002 18:24 schrieb Marc Giger:
> Hi Thomas,
>
> On Sat, 7 Dec 2002 16:57:27 +0000
>
> Thomas White <taw27-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org> wrote:
> > On Sat, 7 Dec 2002 17:11:40 +0100
> >
> > Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org> wrote:
> > > I've seen that DPMS needs an APM conform BIOS. The call is made trough
> > > /dev/apm_bios. Is there an equivalent interface for ACPI? How can I
> > > use the DPMS feature with ACPI? This would be a nice feature for my
> > > Laptop.
> >
> > Proabably not the most helpful of comments... but DPMS seems to work
>
> It's ok:-)
>
> > fine for me with ACPI rather than APM running things - I definitely
> > don't have /dev/apm_bios, but "xset dpms force standby" works properly,
> > to put the screen to sleep.
>
> On my Laptop not:-(
>
> It's also a Vaio GR114EK. This Vaio is a difficult case:-))
>
> What i get with "xset dpms force standby" is:
>
> X Error of failed request: BadMatch (invalid parameter attributes)
>   Major opcode of failed request: 140 (DPMS)
>   Minor opcode of failed request: 6 (DPMSForceLevel)
>   Serial number of failed request: 10
>   Current serial number in output stream: 12
>
> I have activated the DPMS in XF86Config with 'Option "DPMS"'
> What I get is:
>
> ....
> Option "DPMS" is not used
> <snip>
> Open APM failed (/dev/apm_bios) (No such device)
> ...
>
> > ( Sony Vaio FX601 with Linux 2.4.19 + ACPI-20020821 and XFree86 4.2.0 )
> >
> > Tom
> >
> > ______________________
> > Thomas White
> > Downing College
> > Cambridge
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
