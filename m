From: Meelis Roos <mroos@linux.ee>
Subject: Re: [2/3] 2.6.23-rc1: known regressions v3
Date: Mon, 30 Jul 2007 23:03:18 +0300 (EEST)
Message-ID: <Pine.SOC.4.64.0707302301290.14147@math.ut.ee>
References: <46AE0F5D.3000500@googlemail.com> <46AE12F5.4030706@googlemail.com>
 <200707302208.20891.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1185825798=:14147"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S968310AbXG3UDs@vger.kernel.org>
In-Reply-To: <200707302208.20891.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
To: Ismail =?iso-8859-2?q?D=F6nmez?= <ismail@pardus.org.tr>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1185825798=:14147
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

> > Subject         : New ACPI error/warning with Linus' latest GIT
> > References      : http://lkml.org/lkml/2007/7/26/395
> > Last known good : ?
> > Submitter       : Ismail Dönmez <ismail@pardus.org.tr>
> > Caused-By       : ?
> > Handled-By      : ?
> > Status          : unknown
> 
> This started to happen after the second ACPI merge which was for 2.6.23-rc2.

It appeared after new Embedded Controller code was merged into ACPI. It 
might as well be just a debug message or a remainder to add support for 
new queries (whatever these are), but I do not know. The message itself 
seems harmless.

-- 
Meelis Roos (mroos@linux.ee)
---559023410-851401618-1185825798=:14147--
