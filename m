From: n0p <lbernal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: Linux Kernels 2.6.8.1/2.6.9 ACPI bug
Date: Mon, 8 Nov 2004 10:15:34 +0100
Message-ID: <5a23d8070411080115659ed9b6@mail.gmail.com>
References: <5a23d8070411050311ff5f669@mail.gmail.com>
Reply-To: n0p <lbernal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5a23d8070411050311ff5f669-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Hi there
I CC'ed this mail to the people that appeared in the kernel source
credits file that appeared to be implicated in developing ACPI support
for linux, if i sent it to the wrong person/people, please tell me
where I can find the coorect person.

->Dominick Brodowski sugested me to send this message to this mailing
list, so there it goes

Also forgive my bad english, i'm spanish :P

Well, i found that in the kernel 2.6.8.1 and 2.6.9, the ACPI behiavor
is really weird.
I use a compaq nx9010 laptop with a VIA 7101 chipset with a 3.06
Pentium 4 Mobile proccessor running a recently updated SuSE 9 with a
2.6.8.1 and now a 2.6.9 kernel compiled fron the original
www.kernel.org sources with no patches.
Well, It seems that the ACPI locks on startup (i.e. the battery
status) and won't change the reading until i issue about 5 or 6 times
"acpi -V".
Also similar things happen to the proccessor ACPI performance-states,
that won=B4t change until i issue the (i.e.) echo 0 >
/proc/acpi/proccessor/CPU0/performance many times. Also the buttons in
the keyboard to modify the LCD brightness have a sluggish behiavor and
sometimes they are like being alive!

These aren't really important issues, but i'd like to help in
everything I can to the development of open source projects.

Contact me for anything you want, and go on, you are doing a really good wo=
rk.

Luis Bernal.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
