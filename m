From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] x86: reduce srat verbosity in the kernel log
Date: Tue, 27 Oct 2009 21:08:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0910272103080.8988@chino.kir.corp.google.com>
References: <20091023233743.439628000@alcatraz.americas.sgi.com> <20091023233750.702443000@alcatraz.americas.sgi.com> <87pr8ay6tc.fsf@basil.nowhere.org> <4AE710C9.2070307@sgi.com> <alpine.DEB.2.00.0910271158490.24696@chino.kir.corp.google.com>
 <4AE75162.7080903@sgi.com> <alpine.DEB.2.00.0910271323410.32543@chino.kir.corp.google.com> <4AE75B38.8070301@sgi.com> <alpine.DEB.2.00.0910271345400.9183@chino.kir.corp.google.com> <4AE7C057.7030605@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755846AbZJ1EJT@vger.kernel.org>
In-Reply-To: <4AE7C057.7030605@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Mike Travis <travis@sgi.com>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Oct 2009, Yinghai Lu wrote:

> can you change the apic to hex print?
> 

That would be an extension made on top of my patch (which may be difficult 
without adding an additional library function to be used in this case 
since it relies on bitmap_scnlistprintf()).  It's been printed as an 
unsigned int for well over four years so I don't see any specific urgency, 
anyway.
