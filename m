From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: RE: [Patch] DSDT in initrd v0.2
Date: Thu, 8 May 2003 12:02:09 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305081155380.20031@dynast.gaugusch.at>
References: <A3C83F41488BD61195C3000802252FC135C3A8@dubim07742.ie.ml.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A3C83F41488BD61195C3000802252FC135C3A8-SI4JNLCqwGbcq19Bq1crS1aTQe2KTcn/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Breathnach, Proinnsias (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On May 8, Breathnach, Proinnsias (Dublin) <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org> wrote:
> Markus,
> 	As a suggestion, adding a file, defaulting to something like
> default.dsdt to the initrd would probably be a better method, allowing
> distribution vendors to ship known working dsdt's for many platforms (with
> currently buggy dsdt's ...) they could then customise grub / lilo at install
> time and add the acpi-dsdt=compaq-evo.dsdt to the kernel parameters ?
> Does any of this make sense ?
I think that the initrd only contains the most necessary things, e.g. not
dsdt's for 1000 different models, but only for the one PC that needs it.

I think that my approach is good enough for that and there is no need to
pass any additional parameters with file names. Either there is a DSDT in
the initrd or not.

The initrd is also usually rebuilt for each machine after installation,
containing only the required drivers for the current machine and nothing
more. Same with the DSDT, it would just be appended to the just-created
initrd.

Maybe some kernel hacker can tell me, if filesystem drivers are
available at the ACPI init time, but it would just make everything more
complicated and my approach is clean enough for my taste.

Markus

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
