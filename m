From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH 0/4] fujitsu-laptop: clean-ups and fixes
Date: Fri, 31 Jul 2009 18:10:21 +0930 (CST)
Message-ID: <200907310840.n6V8eLlA006715@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:60369 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbZGaIkh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Jul 2009 04:40:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-kernel@vger.kernel.org, julia@diku.dk, bzolnier@gmail.com

[PATCH 0/4] fujitsu-laptop: clean-ups and fixes

This patch series against fujitsu-laptop contains corrections to NULL
pointer tests, removal of redundant tests, fixes to the driver
registration/unregistration and other minor cleanups.

The patches have been sourced from various authors - credits appear in the
individual patches.

Please consider applying to linux-acpi.

Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Regards
  jonathan

