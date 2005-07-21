From: Romano Giannetti <romanol@upco.es>
Subject: try acpi -V & acpi -V & acpi -V (was Linux v2.6.13-rc3)
Date: Thu, 21 Jul 2005 17:30:18 +0200
Message-ID: <20050721153018.GA31835@pern.dea.icai.upco.es>
References: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com> <200507211209.46039.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261794AbVGUPeX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200507211209.46039.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hmmm... switched today on my Vaio laptop to 2.6.13-rc3. Known 
(see http://bugme.osdl.org/show_bug.cgi?id=4124) is still here. 
A fact that could help, or not, chasing it down: when there are problems 
with acpi events, it happens the following too: 

# acpi -V & acpi -V & acpi -V 
[2] 23884
[3] 23885
     Battery 1: charged, 0%
     Thermal 1: ok, 73.0 degrees C
  AC Adapter 1: on-line
[2]  - 23884 done       acpi -V
rukbat:~/tmp%
     Battery 1: charged, 0%
     Thermal 1: ok, 73.0 degrees C
  AC Adapter 1: on-line

[3]  + 23885 done       acpi -V

Battery 1: charging, 93%, 06:22:58 until charged
     Thermal 1: ok, 73.0 degrees C
  AC Adapter 1: on-line     


It happens just sometime, bust repeating acpi -V & acpi -V in fast succession 
it gives a 0% reading in few tries. Kernel is vanilla, no patch applied. 


HTH,
    Romano 
  
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
