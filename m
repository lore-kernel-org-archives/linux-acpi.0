From: Bernard Blackham <bernard@blackham.com.au>
Subject: Re: since 2.6.9 reboots instead of poweroff (solved)
Date: Mon, 22 Nov 2004 23:55:37 +0800
Message-ID: <20041122155537.GA3007@blackham.com.au>
References: <419FA101.5050304@tyrell.hu> <200411202118.29532.spambouncer@skraemer.de> <20041121015117.GM2694@blackham.com.au> <41A06B7F.5030905@tyrell.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Return-path: <softwaresuspend-help-admin@lists.berlios.de>
Content-Disposition: inline
In-Reply-To: <41A06B7F.5030905@tyrell.hu>
Sender: softwaresuspend-help-admin@berlios.de
Errors-To: softwaresuspend-help-admin@berlios.de
List-Help: <mailto:softwaresuspend-help-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-help@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-help>,
	<mailto:softwaresuspend-help-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-help>,
	<mailto:softwaresuspend-help-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-help/>
To: Akos Maroy <darkeye@tyrell.hu>
Cc: Sebastian =?iso-8859-1?Q?Kr=E4mer?= <spambouncer@skraemer.de>, softwaresuspend-help@lists.berlios.de, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 21, 2004 at 11:18:39AM +0100, Akos Maroy wrote:
> Bernard Blackham wrote:
> I commented the above out, and rebooted with that kernel, but the effect 
> is the same - it reboots instead of powering off :(

Gah. What I said didn't actually make any sense - that code never
even gets called on shutdown.

Here is a workaround that works for me. It's not the correct the
solution, but probably suffices unless you want wakeup events which
are not the power button :)

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi-reboot.diff"

--- linux-2.6.9/drivers/acpi/hardware/hwsleep.c.orig	2004-11-22 23:37:21.000000000 +0800
+++ linux-2.6.9/drivers/acpi/hardware/hwsleep.c	2004-11-22 23:37:28.000000000 +0800
@@ -299,11 +299,6 @@
 	}
 	acpi_gbl_system_awake_and_running = FALSE;
 
-	status = acpi_hw_enable_all_wakeup_gpes (ACPI_ISR);
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
 	/* Get current value of PM1A control */
 
 	status = acpi_hw_register_read (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_CONTROL, &PM1Acontrol);

--pWyiEgJYm5f9v55/--
