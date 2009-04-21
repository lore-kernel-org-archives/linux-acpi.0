From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] Add support for more dell-wmi hotkeys
Date: Tue, 21 Apr 2009 20:12:42 +0100
Message-ID: <20090421191242.GA8445@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com> <49EE09D9.2060209@dell.com> <20090421183100.GA8120@srcf.ucam.org> <49EE1945.2080808@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754979AbZDUTM6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49EE1945.2080808@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 21, 2009 at 02:06:45PM -0500, Mario Limonciello wrote:

> Volume controls are still controlled via scan codes sent out by the EC. 
> This means the behavior doesn't change at all.  The keycodes that come
> via WMI are just to inform the OS (or more specifically an application
> on the OS) of the volume change.

Hm. But if we get the scancode, presumably we can do this anyway?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
