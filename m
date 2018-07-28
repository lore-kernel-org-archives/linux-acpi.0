From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] ACPI fix for v4.18-rc7
Date: Fri, 27 Jul 2018 23:20:47 -0400
Message-ID: <CAJvTdKnpdJA10LMsKVjKqf5bJSQLrRhbLO1E6LrAEEd9aP64xg@mail.gmail.com>
References: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
 <CA+55aFx0SEn1AUspujpr-TDGgJkphrRJz_oL_R+XVxUUWV4pkg@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB4FB32@ORSMSX110.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com> <CA+55aFz9J78kJRrECy=uN8tC9w=MoMQg_Bn6zVMHrTcXDtzQag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFz9J78kJRrECy=uN8tC9w=MoMQg_Bn6zVMHrTcXDtzQag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: erik.schmauss@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

>   ACPI Warning: \_SB.IETM._ART: Return Package type mismatch ..

_ART is the AML method for "Active Cooling Relationship Table".
iIt tells the system how fans are related to temperature sensors.

It is likely that Windows uses DPTF on this platform, and since DPTF
is not using _ART, Linux may be pointing out a vestigial _ART.

Anyway, if your system doesn't handle being hot very well -- this error
message is related to that capability.

cheers,
-Len
