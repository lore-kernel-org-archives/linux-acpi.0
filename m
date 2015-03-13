From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC v2][PATCH 0/2] PNP: Avoid potential error code path problems
Date: Fri, 13 Mar 2015 01:42:24 +0100
Message-ID: <10735840.fKeKX5WA1g@vostro.rjw.lan>
References: <2163789.xYALhKGkH0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2163789.xYALhKGkH0@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, March 12, 2015 02:20:07 AM Rafael J. Wysocki wrote:
> Hi,
> 
> These two patches fix potential issues related to failing device registration
> in the PNP subsystem.

I overlooked the fact that the registration of a PNP device cannot be put
under pnp_lock (as it will deadlock), so new version follows.  Patch [1/2]
is the same as before, but with a shorter changelog, patch [2/2] has been
reworked.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
