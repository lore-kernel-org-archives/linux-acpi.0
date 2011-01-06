From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Bug 25042] New: RAM buffer I/O resource badly interacts with
 memory hot-add
Date: Wed, 5 Jan 2011 18:20:15 -0800
Message-ID: <AANLkTikF75EzTQAgCSVf-yGva2ioTHUVa2VTJ949EQ_q@mail.gmail.com>
References: <bug-25042-27@https.bugzilla.kernel.org/> <20110104135148.112d89c5.akpm@linux-foundation.org>
 <20110106111231.4fc98855.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20110106111231.4fc98855.kamezawa.hiroyu@jp.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-acpi@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, petr@vandrovec.name, akataria@vmware.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 5, 2011 at 6:12 PM, KAMEZAWA Hiroyuki
<kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> Hmm ? Why do you need to place "hot-added" memory's address range next to System
> RAM ? Sparsemem allows sparse memory layout.

Well, even without sparsemem, why couldn't the initial memory image
just be more nicely aligned to 256MB or something?

                          Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
