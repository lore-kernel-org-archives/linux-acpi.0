From: law-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: Re: Why does gcc suck at switch()?
Date: Sat, 11 Oct 2003 21:20:47 -0600
Sender: gcc-owner-/MQLu3FmUzdAfugRpC6u6w@public.gmane.org
Message-ID: <200310120320.h9C3KlMC009932@speedy.slc.redhat.com>
References: <20031003145614.GP24824@parcelfarce.linux.theplanet.co.uk>
Reply-To: law-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-83858-gcc-@public.gmane.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc-@public.gmane.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc-/MQLu3FmUzdAfugRpC6u6w@public.gmane.org>
List-Help: <http://gcc.gnu.org/ml/>
In-Reply-To: Your message of "Fri, 03 Oct 2003 15:56:14 BST."
             <20031003145614.GP24824-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: gcc-/MQLu3FmUzdAfugRpC6u6w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <20031003145614.GP24824-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>, Matthew 
Wilcox writes:
 >
 >Why does gcc generate worse code for switch() statements than for
 >multiple-if?
Because it apparently is trying to do the tests in range form rather
than naively generating a simple test for each case in the switch
(there's no way to actually verify that since you didn't provide a
complete testcase).


The range-forms can be more effective in some cases or at least that's
the claim.  I'm not particularly familiar with that code so I've never
tried to re-tune it.  [ I have noticed it generating spectacularly bad
code in certain circumstances, yours may just be another of those cases. ]


jeff
