From: Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org>
Subject: Re: ACPI (20030522, 20030619) breaks 3c59x in 2.4, 2.5
Date: Tue, 24 Jun 2003 13:54:45 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EF81FE5.6060608@relex.ru>
References: <Pine.LNX.4.33.0306241137250.996-100000@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000503060505000409040803"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0306241137250.996-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503060505000409040803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi !
> Salut Yaroslav,
> I am curios what the /proc/interrupts diff looks like...
Huh. Easily :-) Just two quick reboots :-)

yarick@/tmp>diff interrupts.acpi interrupts.acpi=off
2,3c2,3
<   0:      66065          XT-PIC  timer
<   1:        192          XT-PIC  i8042
---
  >   0:      59038          XT-PIC  timer
  >   1:        139          XT-PIC  i8042
5a6
  >   5:        187          XT-PIC  eth0
7,9c8,9
<   9:          2          XT-PIC  acpi
<  12:         55          XT-PIC  i8042
<  14:       2686          XT-PIC  ide0
---
  >  12:        343          XT-PIC  i8042
  >  14:       2669          XT-PIC  ide0
yarick@/tmp>


With all the best, yarick at relex dot ru


--------------000503060505000409040803
Content-Type: text/plain;
 name="interrupts.acpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts.acpi"

           CPU0       
  0:      66065          XT-PIC  timer
  1:        192          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  CS46XX
  8:          1          XT-PIC  rtc
  9:          2          XT-PIC  acpi
 12:         55          XT-PIC  i8042
 14:       2686          XT-PIC  ide0
 15:         25          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


--------------000503060505000409040803
Content-Type: text/plain;
 name="interrupts.acpi=off"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts.acpi=off"

           CPU0       
  0:      59038          XT-PIC  timer
  1:        139          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  CS46XX
  5:        187          XT-PIC  eth0
  8:          1          XT-PIC  rtc
 12:        343          XT-PIC  i8042
 14:       2669          XT-PIC  ide0
 15:         25          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


--------------000503060505000409040803--



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
