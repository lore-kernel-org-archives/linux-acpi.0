From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Tue, 13 Sep 2005 17:22:58 +0200
Message-ID: <E1EFCcc-0008Jy-00@dorka.pomaz.szeredi.hu>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu> <20050907183218.GA773@openzaurus.ucw.cz> <E1EDgJz-0000PH-00@dorka.pomaz.szeredi.hu> <20050910215552.GA2463@openzaurus.ucw.cz>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20050910215552.GA2463-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org> (message from Pavel
	Machek on Sat, 10 Sep 2005 23:55:53 +0200)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pavel-+ZI9xUNit7I@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Okay, so ACPI is basically okay, but fan driver is confused.
> You need to add code to handle suspend and resume into fan.c.
> Probably force everything on for suspend, and sync it with
> software expectations after resume.

Also how do you explain the fact, that removing the fan and
thermal_zone modules before suspend and inserting them after resume
doesn't help at all?

It seems to me as if something in core ACPI is breaking.

Miklos


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
