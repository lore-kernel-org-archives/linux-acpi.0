From: Fabio Sirna <farnis-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: Re: Acer travelmate 210 txr
Date: Sun, 20 Apr 2003 13:41:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030420114140.GA4809@thecrow.it>
References: <20030420112431.GA2719@thecrow.it>
Reply-To: farnis-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030420112431.GA2719-KjLHrUw5Z6+onA0d6jMUrA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alle apr 20 at 01:24, Fabio Sirna scrisse:

>I read on acpi.sf.net about the DSDT table, but I don't understand very
>well, and I didn't find any DSDT table for my laptop.
>If you have any suggestion, please help me.

I do

acpidmp FACP | acpitbl > FACP.log

acpidmp DSDT | acpidisasm > DSDT.log

and I've logged the output. If someone wants the log, I can post it.
I've compressed it on acpi.tar.gz (32K).

-- 
Fabio
_____________________________________________________________________
Envie de discuter en "live" avec vos amis ? Télécharger MSN Messenger
http://www.ifrance.com/_reloc/m la 1ère messagerie instantanée de France



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
