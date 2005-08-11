From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Thermal trouble on 64-bit
Date: Thu, 11 Aug 2005 16:13:28 +0200
Message-ID: <42FB5D08.5020406@suse.de>
References: <20050807201852.42535.qmail@web50207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050807201852.42535.qmail-Jk2qPsSbc8CA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Brannlund <johan_brn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Brannlund wrote:
> Since I didn't get a reply the first time, I thought I'd try to provide
> some more information in the hope that someone will take pity on me.
> The thermal control on my AMD Turion HP 6125 laptop doesn't work quite
> right. 
> The fan often gets "stuck" on whatever speed it had initially and the
> temperature readings also often do not change after a few minutes of
> running. Doing "rmmod thermal; modprobe thermal" makes the temperature
> readings in /etc/acpi/thermal/ start updating again, at least for a few
> minutes when I have to repeat the procedure. The kernel is Ubuntu's
> 2.6.12-6-amd64-k8. Maybe I should mention that I have to boot the
> kernel with "noapic" to get it to run at all.
> 
> Does anyone know what might be causing this?
> 
You could also try to set /proc/acpi/thermal_zone/*/polling_frequency
to e.g. 5 seconds.
Maybe it helps?

   Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
