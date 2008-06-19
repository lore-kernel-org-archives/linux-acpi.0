From: "Jeff Trull" <linmodemstudent@gmail.com>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Thu, 19 Jun 2008 09:40:30 -0700
Message-ID: <685450530806190940g7bd9edb9q3d98050755aee345@mail.gmail.com>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
	 <20080619150947.GA19908@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6428_30609391.1213893630789"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:18519 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbYFSQkc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jun 2008 12:40:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so848520fkq.5
        for <linux-acpi@vger.kernel.org>; Thu, 19 Jun 2008 09:40:30 -0700 (PDT)
In-Reply-To: <20080619150947.GA19908@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

------=_Part_6428_30609391.1213893630789
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Delighted to!

On Thu, Jun 19, 2008 at 8:09 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sat, May 31, 2008 at 12:15:50PM -0700, Jeff Trull wrote:
>
>> I'm running kernel 2.6.20 on a laptop with an ATI IGP 320M Northbridge
>> and an Athlon XP.  DSDT has a _PTS but no _GTS.  I'm comfortable
>> recompiling the kernel.  Any suggestions as to how to proceed,
>> experiments to run, etc.?
>
> Hi Jeff,
>
> Could you attach the output of lspci -vxxx -s 0:0.0 ? Needs to be run as
> root.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>

------=_Part_6428_30609391.1213893630789
Content-Type: application/octet-stream; name=lspci_vxx_000
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhnkwarp0
Content-Disposition: attachment; filename=lspci_vxx_000

MDA6MDAuMCBIb3N0IGJyaWRnZTogQVRJIFRlY2hub2xvZ2llcyBJbmMgQUdQIEJyaWRnZSBbSUdQ
IDMyME1dIChyZXYgMTMpCglGbGFnczogYnVzIG1hc3RlciwgNjZNSHosIG1lZGl1bSBkZXZzZWws
IGxhdGVuY3kgNjQKCU1lbW9yeSBhdCBlMDAwMDAwMCAoMzItYml0LCBwcmVmZXRjaGFibGUpIFtz
aXplPTY0TV0KCU1lbW9yeSBhdCBkYzQwMDAwMCAoMzItYml0LCBwcmVmZXRjaGFibGUpIFtzaXpl
PTRLXQoJSS9PIHBvcnRzIGF0IDFjMTAgW2Rpc2FibGVkXSBbc2l6ZT00XQoJQ2FwYWJpbGl0aWVz
OiBbYTBdIEFHUCB2ZXJzaW9uIDIuMAowMDogMDIgMTAgYjAgY2EgMDYgMDAgMzAgMDIgMTMgMDAg
MDAgMDYgMDAgNDAgMDAgMDAKMTA6IDA4IDAwIDAwIGUwIDA4IDAwIDQwIGRjIDExIDFjIDAwIDAw
IDAwIDAwIDAwIDAwCjIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMAozMDogMDAgMDAgMDAgMDAgYTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAKNDA6IDAwIDAwIDAwIDAwIDBiIDA1IDAwIDAwIDAwIDAwIDAwIDAwIDA0IDBkIDAwIDAwCjUw
OiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo2MDogNGQg
MGQgYTIgODUgMmQgMGEgNzIgMmMgMDAgMDAgMDAgMDAgZDQgMTkgMDYgZDUKNzA6IGUwIDBkIDIw
IDMxIDg0IDg0IDg0IDg0IDAwIDAwIDEwIDAwIDAwIDAwIDAwIDAwCjgwOiAwMCAwMCAwMCAwMCA5
NiAxMCA4MyAwMCAzMiAwMCAzMSAwMCAyMyAwMCAwMCAwMAo5MDogMDAgMDAgMDAgMDAgMDAgMDAg
MDUgMDAgMDAgMDAgZTQgN2YgODQgMDAgMDAgMDAKYTA6IDAyIDAwIDIwIDAwIDE3IDAyIDAwIDBm
IDA0IDAzIDAwIDAwIDAzIDAwIDAwIDAwCmIwOiAwMCAwMCAwMiAwMCAwOCAwMCAwMCAwMCAwNCAw
NCAwNCAwNCAwMCAwMCAwMCAwMApjMDogMDAgMDAgMDAgZmYgNWEgMTUgMDUgMGYgMDAgMWYgZmYg
MWYgMDAgMDAgODQgMDAKZDA6IGViIDI3IDBkIDAwIGViIDI3IDRkIDAwIDZhIDAwIDYwIDEwIDAw
IDAwIDAwIGZmCmUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCBmZiAwMCAwMCAw
MCBmZgpmMDogMGIgMDAgMDkgMDAgMDAgMDAgMDAgZmYgMDAgMDggMTAgMTggMDAgMDAgMDAgMDAK
Cg==
------=_Part_6428_30609391.1213893630789--
