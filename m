From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: status update for current development on ASUS M2N
Date: Mon, 27 Sep 2004 14:33:20 +0200
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <20040927123320.GA28634@hell.org.pl>
References: <m3lleww12c.fsf@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
Content-Disposition: inline
In-Reply-To: <m3lleww12c.fsf@brain.gnuhh.org>
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: acpi-devel@lists.sourceforge.net
Cc: SoftwareSuspend-devel@lists.berlios.de
List-Id: linux-acpi@vger.kernel.org

Thus wrote Georg C. F. Greve:
> However: If I suspend to ram once and then suspend to disk, resume
> From disk works fine, but about 20 seconds to 1 minute later, the
> load suddenly jumps to 100% and stays there.

I had that issue too, with 2.6.9-rc1 I s'pose, but I thought it was just
bug #3193 revisited and didn't really investigate. Does changing swsusp2 to
_not_ use ACPI S4 help?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
