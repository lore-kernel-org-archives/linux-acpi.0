From: Martin Lorenz <martin-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Subject: Re: [patch] 2.6.1-mm3 acpi frees free irq0
Date: Thu, 15 Jan 2004 16:11:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4006AD9E.50908@lorenz.eu.org>
References: <16390.43574.867869.286685@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16390.43574.867869.286685-4mDQ13Tdud8Jw5R7aSpS0dP8p4LwMBBS@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Jes Sorensen wrote:

> Hi,
> 
> There is a bug in the ACPI code found in 2.6.1-mm3 where if it can't
> find the interrupt source for the ACPI System Control Interrupt Handler,
> it end up trying to free irq 0.
> 
> Included patch fixes the problem.
> 
could this bug have caused a panic on system halt?
...it went away so fast into reboot, i could not read the oops

[...]
martin lorenz
--
	They that can give up essential liberty
	to obtain a little temporary safety
	deserve neither liberty nor safety.
				-- Benjamin Franklin



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
