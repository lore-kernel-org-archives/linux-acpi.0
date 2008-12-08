From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Mon, 08 Dec 2008 09:16:36 +0800
Message-ID: <1228698996.4181.24.camel@yakui_zhao.sh.intel.com>
References: <4925EF01.2070405@gmail.com>
	 <1227229754.15014.280.camel@rzhang-dt>  <200812072217.04150.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39257 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbYLHBI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Dec 2008 20:08:29 -0500
In-Reply-To: <200812072217.04150.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, maxime Poncet <maxime.poncet@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

On Mon, 2008-12-08 at 05:17 +0800, Rafael J. Wysocki wrote:
> On Friday, 21 of November 2008, Zhang Rui wrote:
>From the test it seems that the shutdown is caused by that the
temperature is above the critical threshold.
   >CRT threshold 100
   >the temperature 144C

But the problem is why the temperature is above the critical threshold.
>From the acpidump the temperature is obtained by evaluating the _TMP
object. 
 Method (_TMP, 0, Serialized)
            {
                If (DTSE)
                {
                    If (LGreaterEqual (DTS1, DTS2))
                    {
                        Return (Add (0x0AAC, Multiply (DTS1, 0x0A)))
                    }

                    Return (Add (0x0AAC, Multiply (DTS2, 0x0A)))
                }

                If (ECON)
                {
                    Return (Add (0x0AAC, Multiply
(\_SB.PCI0.LPC.WBEC.DTMP, 0x0A)))
                }

                Return (0x0BB8)
            }
>From the above definition of _TMP object the temperature will be related
with the following factor:
   a. DTSE . If the DTSE is non-zero, the temperature will be the
maixium of DTSE1/DTS2. But the DTSE/DTS1/DTS2 is defined in ACPI NVS
memory region. If the DTSE is non-zero, in theory the shutdown will
happen on the kernel of 2.6.28-rc3.
   b. DTMP. When the DTSE is zero, the temperature will be obtained from
DTMP, which is an EC internal register. 

Hi, Maxime
   As there exist some changes related with EC between 2.6.28-rc3/rc5,
Will you please use the git-bisect to identify which commit causes the
regression?
   Thanks.


> > > ...
> > > temperature:             51 C
> > > temperature:             51 C
> > > temperature:             144 C
> > > 
> > > And then it shutdowns because critical temperature was reached
> > > 
> > > Another thing that might be important : the output of dmesg
> > > Every 5 seconds this message appears (not in 2.6.28-rc3):
> > > 
> > > ACPI: Transitioning device [FAN] to D3
> > > ACPI: Unable to turn cooling device [ffff81007fb656d0] 'off'
> > > 
> > > Hope it will help you.
> 
> I wonder why _may_ be the reason of this.  Alex?
> 
> Rafael

