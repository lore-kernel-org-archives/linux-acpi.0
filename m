From: "Breathnach, Proinnsias (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>
Subject: RE: [Patch] DSDT in initrd v0.2
Date: Thu, 8 May 2003 11:11:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <A3C83F41488BD61195C3000802252FC135C3AB@dubim07742.ie.ml.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Markus Gaugusch' <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> ----Original Message-----
> On May 8, Breathnach, Proinnsias (Dublin) <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>
> wrote:
> > Markus,
> > Does any of this make sense ?
> I think that the initrd only contains the most necessary things, e.g. not
> dsdt's for 1000 different models, but only for the one PC that needs it.
> 
	<snip>

> The initrd is also usually rebuilt for each machine after installation,
> containing only the required drivers for the current machine and nothing
> more. Same with the DSDT, it would just be appended to the just-created
> initrd.
Both valid points ... I think that it's fair to say that if the machine is
going to have a DSDT appended, it'll be done at initrd re-generation time
...

P



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
