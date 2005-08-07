From: Johan Brannlund <johan_brn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Thermal trouble on 64-bit
Date: Sun, 7 Aug 2005 13:18:52 -0700 (PDT)
Message-ID: <20050807201852.42535.qmail@web50207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Since I didn't get a reply the first time, I thought I'd try to provide
some more information in the hope that someone will take pity on me.
The thermal control on my AMD Turion HP 6125 laptop doesn't work quite
right.=20
The fan often gets "stuck" on whatever speed it had initially and the
temperature readings also often do not change after a few minutes of
running. Doing "rmmod thermal; modprobe thermal" makes the temperature
readings in /etc/acpi/thermal/ start updating again, at least for a few
minutes when I have to repeat the procedure. The kernel is Ubuntu's
2.6.12-6-amd64-k8. Maybe I should mention that I have to boot the
kernel with "noapic" to get it to run at all.

Does anyone know what might be causing this?

- Johan






	=09
____________________________________________________
Start your day with Yahoo! - make it your home page=20
http://www.yahoo.com/r/hs=20
=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
