From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: fan control
Date: Thu, 1 May 2003 18:51:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030501185137.C926@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

I noticed that not only can I check the status of the fan in /proc/acpi/fan but
I can change it. Since this issue does not seem to be documented (am I wrong?)
I want to be sure I am not doing anything wrong.

Here is the structure of my /proc/acpi/fan directory

$ ls -R /proc/acpi/fan
/proc/acpi/fan:
C1D9  C1DA  C1DB  C1DC

/proc/acpi/fan/C1D9:
state

/proc/acpi/fan/C1DA:
state

/proc/acpi/fan/C1DB:
state

/proc/acpi/fan/C1DC:
state

If the fan is off, I see:

$ cat /proc/acpi/fan/*/*
status:                  off
status:                  off
status:                  off
status:                  off

If it is spinning slowly, I get

$ cat /proc/acpi/fan/*/*
status:                  off
status:                  off
status:                  off
status:                  on

If it is at maximum speed, I have

$ cat /proc/acpi/fan/*/*
status:                  on
status:                  on
status:                  on
status:                  on

And analogous things for the intermediate situations.

Now, I noticed that if I echo 0 into the state files, the fan start spinning.
So that, for instance, if I am in the case when only the first state is on,
then

$ cat /proc/acpi/fan/*/*
status:                  off
status:                  off
status:                  off
status:                  on
$ echo -n 0 > /proc/acpi/fan/C1DB/state
$ cat /proc/acpi/fan/*/*
status:                  off
status:                  off
status:                  on
status:                  on

and the fan spins faster...

To go back, it is sufficient to echo 3 into the same file and the
corresponding state goes off.
I understand this procedure might be very dangerous. How am I sure that, after
playing with the fans, the control of them goes back to the thermal zones?

Any pointer is appreciated.

Daniele


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
