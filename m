From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: newbie question:  building w/ CONFIG_ACPI_SLEEP on 2.5.40+
Date: Thu, 17 Oct 2002 20:54:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021017205414.A29983@brodo.de>
References: <2203.63.214.83.221.1034879410.squirrel@65.85.27.130>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2203.63.214.83.221.1034879410.squirrel-49ZD0VaXFhDG25CqQ1ok8A@public.gmane.org>; from nick-acpi-rrCFhXTPMk0L0swiZSXcMb5dPsmED6B0@public.gmane.org on Thu, Oct 17, 2002 at 02:30:10PM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nicholas Mistry <nick-acpi-rrCFhXTPMk0L0swiZSXcMb5dPsmED6B0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 17, 2002 at 02:30:10PM -0400, Nicholas Mistry wrote:
> The one thing i noticed is that i cannot enable the
> CONFIG_ACPI_SLEEP option.  I have tried trough make
> (config|menuconfig|xconfig), andafter i select "Y", the option returns back to the default state of "N".
> 
> I am wonering if
> there are some options that are required to be (un)set for this option to
> work.
> Thanks in
> advance.

CONFIG_SOFTWARE_SUSPEND needs to be set.

	Dominik


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
