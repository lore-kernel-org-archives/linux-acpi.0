From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: broken bm_sts on 82801CA?
Date: Tue, 7 Oct 2003 11:10:37 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031007110948.V6708@root.org>
References: <20031006233406.N4792@root.org> <20031007085536.GB11391@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031007085536.GB11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 7 Oct 2003, Ducrot Bruno wrote:
> On Mon, Oct 06, 2003 at 11:38:07PM -0700, Nate Lawson wrote:
> > My chipset claims to be: Intel 82801CA/CAM (ICH3) and it's on an IBM T23
> > thinkpad.  While testing my Cx driver, I noticed that bm_sts is always
> > set, even when I clear it by writing a 1 to the register.  I _know_ the
> > box is idle so I believe this bit to be broken.  Can anyone confirm this?
> > I noticed the errata probe for the PIIX4 but I don't think it covers my
> > part.
>
> Have you any kind of usb bus support compiled in your kernel?
> If yes, try without.

Ah, I'll try that.  I do have USB support compiled in.  This is on
FreeBSD, btw.

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
