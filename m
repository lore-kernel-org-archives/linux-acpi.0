From: Antonio Distante <antonio.distante-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: presario 2500 hangs on resume s3
Date: Sat, 27 Aug 2005 00:06:50 +0200
Message-ID: <1125094010.29868.3.camel@localhost.localdomain>
References: <1124730128.10429.5.camel@localhost.localdomain>
	 <20050825182457.GB443@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050825182457.GB443-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

> Try it with apic disabled and minimal config...

No luck! I think that my laptop has the problem described in
http://bugzilla.kernel.org/show_bug.cgi?id=2664 for hp nc4000 (my
hardware is pretty much the same). Matthew Garrett thinks that in nc4000
(and maybe in my laptop) the ATI northbridge is not configured to ensure
that memory is self-refreshed when suspended. HP tech support didn't
give useful information and I didn't find northbrige's data sheet.

Best regards,
Antonio



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
