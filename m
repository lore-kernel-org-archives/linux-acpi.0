From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: broken bm_sts on 82801CA?
Date: Wed, 8 Oct 2003 19:28:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031008172800.GI11391@poupinou.org>
References: <20031006233406.N4792@root.org> <20031007085536.GB11391@poupinou.org> <20031007110948.V6708@root.org> <20031008123103.GG11391@poupinou.org> <20031008095321.B10515@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031008095321.B10515-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 08, 2003 at 09:55:35AM -0700, Nate Lawson wrote:
> On Wed, 8 Oct 2003, Ducrot Bruno wrote:
> > On Tue, Oct 07, 2003 at 11:10:37AM -0700, Nate Lawson wrote:
> > > On Tue, 7 Oct 2003, Ducrot Bruno wrote:
> > > > On Mon, Oct 06, 2003 at 11:38:07PM -0700, Nate Lawson wrote:
> > > > > My chipset claims to be: Intel 82801CA/CAM (ICH3) and it's on an IBM T23
> > > > > thinkpad.  While testing my Cx driver, I noticed that bm_sts is always
> > > > > set, even when I clear it by writing a 1 to the register.  I _know_ the
> > > > > box is idle so I believe this bit to be broken.  Can anyone confirm this?
> > > > > I noticed the errata probe for the PIIX4 but I don't think it covers my
> > > > > part.
> > > >
> > > > Have you any kind of usb bus support compiled in your kernel?
> > > > If yes, try without.
> > >
> > > Ah, I'll try that.  I do have USB support compiled in.  This is on
> > > FreeBSD, btw.
> >
> > That more an hardware design issue due to how hotplug work in usb busses
> > in general, and it may need to be workaround, so if anybody haven't yet worked on
> > C-states on FreeBSD..  Please note also that Linux do not workaround that
> > btw.
> 
> I have implemented C-states in freebsd, that's how I ran into this
> problem.  I'll be committing the code once it's cleaned up a little.
> 
> Since Linux always demotes to "don't enter a Cx state" if bm_sts indicates
> activity, are you saying that if you have a USB bus configured in Linux,
> you don't even use C1 (HLT)?
> 

What?  If so, there is a bug somewhere since we should look at bm status only at
C2 (only if we have to go to C3) or C3 state.
Sound like you are right, btw.  I have to look a little deeper.  Thanks for pointing
this.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
