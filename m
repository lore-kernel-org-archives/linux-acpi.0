From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI trouble (AC module, etc.) with Toshiba 1115-S103
Date: Fri, 13 Dec 2002 16:21:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213152117.GF4327@poup.poupinou.org>
References: <20021210092357.GA29390@poup.poupinou.org> <20021213004316.39542.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021213004316.39542.qmail-ugbtuMWqwv6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 12, 2002 at 04:43:16PM -0800, NoZizzing OrDripping wrote:
> 
> --- Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> > On Mon, Dec 09, 2002 at 10:59:22PM -0800, NoZizzing
> > OrDripping wrote:
> > > 
> > > Status report for Toshiba Satellite 1115-S103
> > laptop....
> > > 
> > > Just tried 2.4.20 + acpi-20021205-2.4.20.diff with
> > a Toshiba Satellite
> > > 1115-s103 laptop (new model, BIOS is "first
> > production release", dated
> > > 11/01/2002, street price is between $650 and
> > $1000, depending on
> > > rebates).  Built it all-modular and with debug
> > messages.
> > > 	$ root modprobe ac; dmesg
> > > 
> > > 	exfldio-0122 [31] Ex_setup_region       : Field
> > [ACPW] Base+Offset+Width 38+0+4 is beyond end of
> > region [GPIO] (length 3B)
> 
> > Known issue with most of the Toshiba Satellite
> > series with a Phoenix
> > BIOS.  I guess that Toshiba (or in fact Compal)
> > still don't
> > know how to debug correctly their ASLs.
> > 
> > You need a patched DSDT for this model.
> 
> I don't believe that Toshiba/Microsoft will ever
> change their ways.  This is a brand new model.
> However, it looks to me like I could easily make
> a kernel patch to add a CONFIG_ACPI_RELAXED
> configuration option that will allow these ASL
> mistakes, such as off-by-one on region size, to
> be accepted.  That would allow people to use many
> broken DSDT's without having to go thru all of the
> trouble of the current method of DSDT overriding.

MS miss the check bounding in their AML interpreter, _but_
not in MS XP.  Though, your new brand model could potentially
have the exact same problem with this OS as well.  Really,
this up to Toshiba to debug their DSDT for their Satellites.
Actually, they have to cry to the real ODM, the real manufacturer
of allmost of their Satellite models, that is Compal.
(http://www.compal.com).

A 'real' Toshiba shipping a toshiba bios do not have this bug.
(it has others, but it was fixed by the help of FreeBSD team and
Intel)

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
