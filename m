From: Norbert Preining <preining@logic.at>
Subject: Re: [ACPI] Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Date: Wed, 6 Apr 2005 00:19:03 +0200
Message-ID: <20050405221903.GA21196@gamma.logic.tuwien.ac.at>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at> <20050405204107.GD1380@elf.ucw.cz> <20050405210041.GA16263@gamma.logic.tuwien.ac.at> <20050405211340.GF1380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261809AbVDEWTJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050405211340.GF1380@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Die, 05 Apr 2005, Pavel Machek wrote:
> Well, I do not have working suspend-to-RAM setup close to me... Could
> you try 2.6.12-rc1 to see if reboot problem is -mm specific or not?

2.6.12-rc2 suspends and resumes with the very same config file (well,
after running make oldconfig) without any problem.

So there is a change in -mm1 which triggers this. Should I start with
backing out bk-acpi? or anything else?

> input is known for some funky behaviour, especially with
> synaptics. Disabling cpufreq might be good idea, too...

rc2 with input compiled in and cpufreq compiled in did resume.

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0=
 di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 5996=
6-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
THRUMSTRER (n.)
The irritating man next to you in a concert who thinks he's (a) the
conductor, (b) the brass section.
			--- Douglas Adams, The Meaning of Liff
