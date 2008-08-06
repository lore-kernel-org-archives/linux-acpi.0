From: Pavel Machek <pavel@suse.cz>
Subject: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Wed, 6 Aug 2008 11:02:47 +0200
Message-ID: <20080806090246.GA1572@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755738AbYHFM4S@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Aug  6 11:00:10 amd kernel: ACPI: Critical trip point
Aug  6 11:00:10 amd kernel: Critical temperature reached (128 C),
shutting down.
Aug  6 11:00:10 amd shutdown[24414]: shutting down for system halt

...and machine went down at that point :-(.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
