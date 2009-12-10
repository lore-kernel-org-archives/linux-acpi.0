From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or
 in_atomic
Date: Thu, 10 Dec 2009 19:18:00 +0100
Message-ID: <20091210181800.GM19454@elf.ucw.cz>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com>
 <20091210100907.GA2446@ucw.cz>
 <4B2136D5.1030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761380AbZLJSSH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B2136D5.1030402@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Xiaotian Feng <dfeng@redhat.com>, lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu 2009-12-10 20:58:45, Alexey Starikovskiy wrote:
> Hi Pavel,
> 
> Please elaborate... Your comments "ugly as hell" are too often to be
> specific...
> There is only one use of ACPI_PREEMPTION_POINT(), and it is in the
> ACPICA code,
> which we all agreed to keep OS independent, thus the need for #define.
> Do you see any other way to add preemption point without introducing
> Linux-specific
> code into ACPICA?

I believe we want linux-specific code in acpica at this point.

(Or maybe... I guess other systems have concept of preemption and not
all actions are permitted from all contexts, so maybe something like
that would be important for them, too?)
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
