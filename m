From: Olivier.Tarnus-RfMcyWydPToAvxtiuMwx3w@public.gmane.org
Subject: Is my battery dead???
Date: Tue, 10 Dec 2002 11:46:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF6C971FD4.1C3E6E08-ONC1256C8B.003B2760@domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

I own an asus s8600 and run gentoo linux on it.
I'd like to have more offline time so tried ACPI with both 2.5 series
and 2.4 backport series.

It was a little buggy but system was stable enough :-).
My problem is that my battery (Li-Ion) seems to be broken, but was fully
functional with more than 2 hours of autonomy before running linux ACPI.

Here are the symptoms :
  -When unpluging power it goes down immediatly (i mean not even 1s)
  -While on power, a strange cycle occurs : the charging led light up
during
   10s, then off during 25s and back on...
  -When looking at battery states in proc, the cycle is really strane :
     * First i've got 0 mA and 0 mAh with 12.8V and state discharging
     * Then it briefly show state charging, but 0V 0mAh and 55600 mA!!!
       (That's not a typo error)
     * Then all is at 0 and state is again discharging during 10 sec and
        the cycle restart
  -When using another battery, all works fine ( i mean the computer itself
   seems ok)

I notified that before this problems occured, while running 2.5.46, the
battery was always charging. This could perhaps have broken it...

Could it be possible that internal battery registers have been broken?
Should it be possible to get right registers from a working one and
apply them back to mine???

Should i provide you more infos that may help?

Any idea?

Thanks a lot.

PS : please cc me, i've not suscribed...

Olivier Tarnus
Senior Systems Administration Officer
KNEIP Communication S.A.
30, Grand Rue P.O. Box 729
L-2017 Luxembourg
Tel: (+352) 261 531 343
Fax: (+352) 227 337
e-mail: olivier.tarnus-RfMcyWydPToAvxtiuMwx3w@public.gmane.org


************************************************************************************************************************************************************************************

All information and opinions expressed in this message and/or any
attachments are those of the sender and not necessarily those of Kneip
Communication S.A. There is no guarantee that this message is either
private or confidential, and it may have been altered by unauthorised
sources without your or our knowledge. Kneip Communication S.A. accepts no
responsibility for loss or damage from its use, including damage from virus


***********************************************************************************************************************************************************************************


************************************************************************************************************************************************************************************

All information and opinions expressed in this message and/or any
attachments are those of the sender and not necessarily those of Kneip
Communication S.A. There is no guarantee that this message is either
private or confidential, and it may have been altered by unauthorised
sources without your or our knowledge. Kneip Communication S.A. accepts no
responsibility for loss or damage from its use, including damage from virus


***********************************************************************************************************************************************************************************



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
