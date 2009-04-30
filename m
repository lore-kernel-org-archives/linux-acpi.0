From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot
	even when ignore_ppc=0
Date: Thu, 30 Apr 2009 11:17:46 +0200
Message-ID: <20090430091746.GA2839@elte.hu>
References: <20090415225348.GW8311@plum> <200904291519.29683.trenn@suse.de> <20090429214312.GX7917@plum> <200904301107.45753.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:52899 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbZD3JSE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Apr 2009 05:18:04 -0400
Content-Disposition: inline
In-Reply-To: <200904301107.45753.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: djwong@us.ibm.com, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Thomas Renninger <trenn@suse.de> wrote:

> On Wednesday 29 April 2009 11:43:12 pm Darrick J. Wong wrote:
> > On Wed, Apr 29, 2009 at 03:19:28PM +0200, Thomas Renninger wrote:
> > > Ingo, did you do a BIOS update in between?
> > > The DSDT and SSDTs you added do not contain a _PPC function.
> > > These ACPI tables definitely do not suffer from an initial _PPC
> > > evaluation.
> >
> > P-state tables are probably loaded from separate SSDT tables "CPU0IST" and
> > "CPU1IST".  You can download 'em with something like this:
> >
> > # dmesg | grep IST
> > ACPI: SSDT BFD30566, 01FB (r1  PmRef    CPU0IST   3000 INTL 20030224)
> >            ^addr     ^length
> >
> > # acpidump --addr 0xBFD30566 --length 0x1FB > cpu0ist
> > # iasl -d cpu0ist
> >
> > Then paste cpu0ist.dsl somewhere.
> 
> Oops forgot about the tables loaded at runtime, I take back the definitely :)
> Ingo, can you also do:
> acpidump --addr 0x7F6E609E --length 0x1ED >cpu0ist
> acpidump --addr 0x7F6E628B --length 0x94 >cpu1ist
> acpidump --addr 0x7F6E5DE1 --length 0x238 >cpu0cst
> acpidump --addr 0x7F6E6019 --length 0x85 >cpu1cst

sure - attached.

	Ingo

--sdtB3X0nJg68CQEu
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=cpu0ist
Content-Transfer-Encoding: base64

U1NEVO0BAAABdVBtUmVmAENwdTBJc3QAAAEAAElOVEwTBQUgEEgcXC5fUFJfQ1BVMBRABV9Q
UEMAcAoAYHBcLwVfU0JfUENJMExQQ19FQ19fTFBNRGCgKZJgoCWRXERUMDBcLwVfU0JfUENJ
MExQQ19FQ19fSFQxMHBcTFdTVGCkYBRHB19QQ1QAoEEEkHtDRkdECgEAe1BEQzAKAQCkEiwC
ERQKEYIMAH9AAACZAQAAAAAAAHkAERQKEYIMAH8QAACYAQAAAAAAAHkApBIsAhEUChGCDAAB
EAAAsgAAAAAAAAB5ABEUChGCDAABCAAAswAAAAAAAAB5ABQaWFBTUwCgDntQREMwCgEApE5Q
U1OkU1BTUwhTUFNTEkYGAxIgBgwpBwAADBh5AAAMbgAAAAwKAAAADIMAAAAMAAAAABIgBgw1
BQAADCBOAAAMbgAAAAwKAAAADIMBAAAMAQAAABIgBgzoAwAADMgyAAAMbgAAAAwKAAAADIMC
AAAMAgAAAAhfUFNTEkYGAxIgBgwpBwAADBh5AAAMCgAAAAwKAAAADCwLAAAMLAsAABIgBgw1
BQAADCBOAAAMCgAAAAwKAAAADB0IAAAMHQgAABIgBgzoAwAADMgyAAAMCgAAAAwKAAAADBMG
AAAMEwYAAA==

--sdtB3X0nJg68CQEu
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=cpu1ist
Content-Transfer-Encoding: base64

U1NEVJQAAAABllBtUmVmAENwdTFJc3QAAAEAAElOVEwTBQUgEE8GXC5fUFJfQ1BVMRQWX1BQ
QwCkXC8DX1BSX0NQVTBfUFBDFDRfUENUAKQSLAIRFAoRggwAf0AAAJkBAAAAAAAAeQARFAoR
ggwAfxAAAJgBAAAAAAAAeQAUFl9QU1MApFwvA19QUl9DUFUwX1BTUw==

--sdtB3X0nJg68CQEu
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=cpu0cst
Content-Transfer-Encoding: base64

U1NEVDgCAAABolBtUmVmAENwdTBDc3QAAAEAAElOVEwTBQUgEEMhXC5fUFJfQ1BVMAhDU1Qx
EiMCCgESHgQRFAoRggwAfwAAAAAAAAAAAAAAeQAKAQoBC+gDCENTVDISQwQDCgISHgQRFAoR
ggwAfwAAAAAAAAAAAAAAeQAKAQoBC+gDEh4EERQKEYIMAAEIAAAUEAAAAAAAAHkACgIKAQv0
AQhDU1QzEkEGBAoDEh4EERQKEYIMAH8AAAAAAAAAAAAAAHkACgEKAQvoAxIeBBEUChGCDAAB
CAAAFBAAAAAAAAB5AAoCCgEL9AESHQQRFAoRggwAAQgAABUQAAAAAAAAeQAKAwoRCmQIQ1NU
NBJBBgQKAxIeBBEUChGCDAB/AAAAAAAAAAAAAAB5AAoBCgEL6AMSHgQRFAoRggwAAQgAABQQ
AAAAAAAAeQAKAgoBC/QBEh0EERQKEYIMAAEIAAAWEAAAAAAAAHkACgMKOQpkFEYMX0NTVACg
O5B7Q0ZHRAwAAAABAJJ7UERDMAoQAKQSIwIKARIeBBEUChGCDAB/AAAAAAAAAAAAAAB5AAoB
Cp0L6AOgRQV7Q0ZHRAqAAKALXEMyTkGkQ1NUMaALXEMzTkGkQ1NUMqAhXC8GX1NCX1BDSTBM
UENfRUNfX0FDX19fUFNSpENTVDOgC1xDNE5BpENTVDOkQ1NUNKAYkJJ7Q0ZHRAqAAHtDRkdE
CkAApENTVDOgDntDRkdECiAApENTVDKkQ1NUMQ==

--sdtB3X0nJg68CQEu
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=cpu1cst
Content-Transfer-Encoding: base64

U1NEVIUAAAABu1BtUmVmAENwdTFDc3QAAAEAAElOVEwTBQUgEEAGXC5fUFJfQ1BVMRRDBV9D
U1QAoDuQe0NGR0QMAAAAAQCSe1BEQzEKEACkEiMCCgESHgQRFAoRggwAfwAAAAAAAAAAAAAA
eQAKAQqdC+gDpFwvA19QUl9DUFUwX0NTVA==

--sdtB3X0nJg68CQEu--
