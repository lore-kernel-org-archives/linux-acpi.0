From: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Subject: Re: lid state reported incorrectly; no ac events
Date: Fri, 25 Jul 2003 15:19:18 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307251519.18807.fedor@karpelevitch.net>
References: <F760B14C9561B941B89469F59BA3A847E97081@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E97081-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Пятница 25 Июль 2003 01:58 pm, Grover, Andrew wrote:
> > From: Fedor Karpelevitch [mailto:fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org]
> > so state!=0 is interpreted as "open" whereas (it seems to me)
> > since it
> > is state of the _button_ (not the lid itself), it would be
> > logical that state!=0 means that button is depressed (which means
> > that the lid is closed). Am I making sense here?
> > The only question here is what happens on other laptops or
> > whether this is specified in ACPI docs somewhere?
>
> 10.3.1 _LID
> Evaluates to the current status of the lid.
> Result Code:
> Zero: The lid is closed
> Non-zero: The lid is open

so I guess this is a bug of this laptop. What would be a proper way to 
handle this? Blacklist? Special compile option?

>
> > The other question (issue?) I have is that in acpid log I only
> > see messages for power and lid buttons and the battery (BTW when
> > exactly do these fire? is it only when battery is critically
> > low/fully charged or more often?). I expected to see AC
> > connected/disconnected events and maybe thermal events too. When
> > I compile with acpi debugging output I do see messages on ac
> > plugging/unplugging so I assume it gets detected correctly, but
> > event does not fire. Is that ok or is it a bug?
>
> Probably just not handled by acpid.

Thanks, I'll look into that...

fedor.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
