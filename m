From: Sebastian Kaergel <mailing-HmhXUwHVxSOoYr4blSSd5g@public.gmane.org>
Subject: Re: Linux v2.6.13-rc3
Date: Thu, 14 Jul 2005 00:18:43 +0200
Message-ID: <20050714001843.3c14d071.mailing@wodkahexe.de>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0507122157070.17536-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 12 Jul 2005 22:05:00 -0700 (PDT)
Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org> wrote:

> Dmitry Torokhov:
>   [ACPI] Enable EC Burst Mode

After booting 2.6.13-rc3 on my acer travlemate 291LCI it starts
complaining:

 acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail
 acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail

2.6.13-rc{1,2} did not have this problem.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
