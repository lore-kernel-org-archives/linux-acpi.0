From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compaq 1720US, 2.4.18, acpi-7,24 - Help
Date: Tue, 13 Aug 2002 14:09:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020813120946.GE2605@poup.poupinou.org>
References: <Pine.GSO.4.21.0208122148460.7266-100000@sediment.umd.edu> <1029213980.18063.3.camel@anodyne.mandal> <20020813095553.GB2605@poup.poupinou.org> <20020813104719.GB31846@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020813104719.GB31846-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, "Sourav K. Mandal" <smandal-DPNOqEs/LNQ@public.gmane.org>, Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 13, 2002 at 11:47:19AM +0100, Faye Pearson wrote:
> Ducrot Bruno [ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] wrote:
> > Just a though: why not directly making something like
> > *new_table = (acpi_table_header*) AmlCode;
> > instead of declaring another variable ?
> 
> That's exactly what I do in my patch.  What would be useful for a
> generic patch which could be included in the kernel would be a to
> declare AmlCode as a weak null value as well as putting it inside a
> define set by config.

OK.  I see now.

> 
> People can see if their table is being replaced when they get "DSDT
> being overridden by OS" in their boot messages.
> 

Well, why to put that when configuring kernel.
Actually I would prefer to put an aml file in /boot
and then kernel load it, or something similar.  But it implied to hack
somewhat the way the kernel is initialized, and lilo in order to pass
the name of the file containing the AML, or using grub instead of lilo.

This is already the case under FreeBSD-current, and it is really a cool
feature.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
