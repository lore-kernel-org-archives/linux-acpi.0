From: Johannes Weiner <hannes-kernel@saeurebad.de>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Thu, 8 Nov 2007 16:53:44 +0100
Message-ID: <20071108155344.GA12231@cataract>
References: <1193652664.22149.4.camel@localhost> <200711041417.23920.rjw@sisk.pl> <200711050029.09768.listen@selfservix.org> <200711050118.34610.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761315AbXKHPzY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200711050118.34610.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Michael (rabenkind) Brandstetter" <listen@selfservix.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

is there any reason, why acpi_battery_get_property() should call
acpi_battery_update() at all?

	Hannes
