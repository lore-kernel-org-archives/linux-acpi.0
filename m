From: Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Mon, 28 Apr 2003 21:04:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16045.31555.910630.383445@hotzenplotz.chateau-neukoelln.de>
References: <3EAB29E2.5030702@woogie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3EAB29E2.5030702-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mike Wohlgemuth <mjw-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

> I'm trying to get ACPI working on my Compaq Evo N800c.  Actually, I 
> should say that I have it working, or at least it's loading and I'm 
> seeing entries in /proc/acpi, but whenever I boot with a kernel with 
> ACPI enabled, it breaks PCMCIA.  The drivers attempt to load, but can't 
> find the cardbus controller, which doesn't even show up in lspci.

Hm, I'm running exactly the same model (with Red Hat 8) and don't see
this behaviour. The cardbus controller is detected and assigned to
interrupt 11, where it'll happily do its work.

Are you sure, that this is really related to ACPI? Is the controller
detected if you boot your system without ACPI? Does it show in lspci
then?

Regards,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
