From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Bitfield usage in FADT table?
Date: Tue, 11 Nov 2003 18:55:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031111175503.GF29175@poupinou.org>
References: <20031111161527.GC23128@sh.epita.fr> <20031111170245.GE29175@poupinou.org> <20031111171845.GA19024@dabelg.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031111171845.GA19024-llVo0kcOI43s6UcQ8r3GPg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: max-ZrNlpQwM5lQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 11, 2003 at 06:18:45PM +0100, maximE bizon wrote:
> 
> On Tue, Nov 11, 2003 at 06:02:45PM +0100, Ducrot Bruno wrote:
> 
> > > begin dump of fadt:
> > > [...]
> > > 6e	0
> > > 6f	0
> > > 70	f1
> > > 71	a2
> > > 72	35
> > > 73	78
> > > 74	0
> > > 75	0
> > > [...]
> > > bit wb_invd is 1
> > > bit wb_invd_flush is 0
> > > bit proc_c1 is 0
> > > bit plvl2_up is 0
> > > bit pwr_button is 1
> > > bit sleep_button is 1
> > > bit fixed_rTC is 1
> > > bit rtcs4 is 1
> > > bit tmr_val_ext is 0
> > > bit dock_cap is 1
> > > bit reset_reg_sup is 0
> > > bit sealed_case is 0
> > > bit headless is 0
> > > bit cpu_sw_sleep is 1
> > > 
> 
> > > Is it really what it is supposed to be?
> > 
> > To be what?
> 
> According to the ACPI specs:
> 
> value		bit offset
> =====		==========
> wb_invd		0
> wb_invd_flush	1
> proc_c1		2
> plvl2_up	3
> pwr_button	4
> sleep_button	5
> [...]
> 
> So, for instance, sleep_button should be 0, no ?

No.  This is a double word, so, with endianess issues, you
actually have overwriten with
0x7825a2f1

and bit 5 of 0x7825a2f1 is 1.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
