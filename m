From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] ACPI fix for v4.18-rc7
Date: Fri, 27 Jul 2018 18:30:37 -0700
Message-ID: <CA+55aFz9J78kJRrECy=uN8tC9w=MoMQg_Bn6zVMHrTcXDtzQag@mail.gmail.com>
References: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
 <CA+55aFx0SEn1AUspujpr-TDGgJkphrRJz_oL_R+XVxUUWV4pkg@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB4FB32@ORSMSX110.amr.corp.intel.com> <CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: erik.schmauss@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 27, 2018 at 5:02 PM Schmauss, Erik <erik.schmauss@intel.com> wrote:
>
> The patch below should be able to fix this.

Yes, the error messages seem gone with this.

I see another ACPI warning, but that one has always been there:

  acpi INT33D5:00: intel-hid: created platform device
  ACPI Warning: \_SB.IETM._ART: Return Package type mismatch at index
0 - found Integer, expected Reference (20180531/nspredef-263)
  ACPI: Invalid package element [0]: got number, expecting [R]
  _ART package 0 is invalid, ignored

and doesn't seem to cause any problems. Just mentioning it in case
somebody goes "yeah.."

             Linus
