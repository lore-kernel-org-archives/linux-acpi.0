From: Jamin W. Collins <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
Subject: Re: C1VN, ACPI and ESD/ASD = const CPU
Date: Tue, 27 Aug 2002 11:09:13 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020827110913.46404fb7.jcollins@asgardsrealm.net>
References: <20020827091844.7af7a982.jcollins@asgardsrealm.net>
	<20020827155320.GA2998@whisky.cprm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020827155320.GA2998-kEryGdCNCzRQeIZkGdo+ZQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Aug 2002 16:53:20 +0100
Carlos Morgado <chbm-tNiY1ywYjSU@public.gmane.org> wrote:

> check the irq distribution on an apm and an acpi kernel

ACPI Kernel - 2.4.18 - with ACPI and SWSUP patches
  0:    1204728          XT-PIC  timer
  1:       1219          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5453          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:    1950699          XT-PIC  acpi, usb-uhci, Ricoh Co Ltd RL5c475,
YMFPCI
 11:         55          XT-PIC  sonypi
 12:       9081          XT-PIC  PS/2 Mouse
 14:      89814          XT-PIC  ide0

APM Kernel - 2.4.18 - stock Debian 586tsc 
  0:      34547          XT-PIC  timer
  1:          5          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        190          XT-PIC  orinoco_cs
  8:          3          XT-PIC  rtc
  9:         31          XT-PIC  usb-uhci, Ricoh Co Ltd RL5c475, YMFPCI
 11:          3          XT-PIC  sonypi
 12:         15          XT-PIC  PS/2 Mouse
 14:      68288          XT-PIC  ide0

With the exception of acpi not existing in the APM kernel, they look
exactly the same.

-- 
Jamin W. Collins


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
