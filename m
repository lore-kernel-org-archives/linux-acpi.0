From: David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: [ACPI] ACPI global lock macros
Date: Tue, 9 Dec 2003 11:03:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <16342.7283.350878.950554@napali.hpl.hp.com>
References: <F760B14C9561B941B89469F59BA3A8470255EFB3@orsmsx401.jf.intel.com>
	<3FD61CA5.6050203@google.com>
Reply-To: davidm@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3FD61CA5.6050203@google.com>
To: Paul Menage <menage@google.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

>>>>> On Tue, 09 Dec 2003 11:04:05 -0800, Paul Menage <menage@google.com> said:

  Paul> Grover, Andrew wrote:

  >> BTW, i386, x86_64 and ia64 all have this macro, so these all might need
  >> to be looked at.


  Paul> Yes, it was the differences between the i386 and x86_64
  Paul> versions that made me notice this problem. The ia64 version is
  Paul> in C, so looks safer.  Ideally there would be a common C
  Paul> definition - the only arch-specific part should be the locked
  Paul> cmpxchg, unless this lock is likely to be taken/released so
  Paul> often that it's performance critical.

As far as ia64 is concerned, you could replace ia64_cmpxchg4_acq()
with cmpxchg().  That should just work.  Of course, as you point out,
that wouldn't work on x86 UP because of the missing "lock" prefix.
Sounds like you'd need to add something along the lines of
device_atomic_cmpxchg() or something like that...

	--david
