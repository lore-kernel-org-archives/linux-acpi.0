From: Karol Kozimor <kkozimor@aurox.org>
Subject: Re: [ACPI] Re: 2.6.8.1-mm1 hangs on boot with ACPI
Date: Thu, 19 Aug 2004 16:12:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200408191612.48033.kkozimor@aurox.org>
References: <B44D37711ED29844BEA67908EAF36F039A1A4E@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266209AbUHSOMX@vger.kernel.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F039A1A4E@pdsmsx401.ccr.corp.intel.com>
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: "Li, Shaohua" <shaohua.li@intel.com>, eric.valette@free.fr, "Brown, Len" <len.brown@intel.com>, Pontus Fuchs <pontus.fuchs@tactel.se>, Greg KH <greg@kroah.com>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Thursday 19 of August 2004 15:54, Li, Shaohua wrote:
> Why this breaks ACPI? ACPI just try to reserve the IO port declared in
> DSDT (ACPI itself doesn't use the io ports), but if the attempt failed,

_TMP indirectly tries (and fails) to access HSTS field which is in the 
reserved region. Furthermore, the loop in the HBSY method that gets 
referenced keeps kacpid very busy during (possibly) thermal interrupt 
handling, thus increasing the system load and temperature, and in turn, 
the frequency of thermal notifies.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
