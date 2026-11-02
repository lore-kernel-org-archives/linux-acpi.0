Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618163;
	b=e4CCnJLGot9wWXzJtEo9fYR+JkmgQ5WEcCeXVx0owk0uok2Vwxn3lJfWE9hZm87LgqvX
	 JyiZ4NKOtI5f3rPc/Vj0JtDIjbLKYlXJDcnSc6uqrOiRqeBmACtBGITVRrCndUnzWLHoC
	 QEJXFjYX2PVyh5JvWrsMLQS0bDWvsoD0kmkDHIynAq90tAmM5FXJXfb50ZbHwuoo3aYnK
	 D6uHXtuOmT2ze5nwnF/g3e9l0PPkCXtjr9i6x6MCyUT6Cu0pbZFryIgFWyENRxJnIyor6
	 JLixUrRbNy7294iC7JAPIufKxyecll6fvw0Oa8DQzoP017lrIBTsT5PwWYzT2hMhRyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618163;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TGJD+KdqvScwUJzjEuZa6O0XuHzgx+ke4p83StJ2m7Y=;
	b=uD/KBOQiR0YZxvcxpjCB/slzmWduQXjPkYO1OZoKhsz1ruBFQNANYlIXcmeX87vB8WFn
	 yNLlpsALllQe5DRcYrroo5pAdY48iu7XDKuHM0oDQIx1AIHPOxVuGI9g6U4xk1N5TysX+
	 CxqN45Ag/q+IS0Dh9WpGesIk541zp0XstSyic0l53sCDYeHX2VQ48nkiG8M2sZps0VwNh
	 Ea3tjYCCC67vrcshUnUBNoRbLFulf7wYDQb/qojHtg1bFu/BqDaCWrPDTDXqMbXFMKYpd
	 /uOC/jqHJwjE/PpO6nByxCFS75Ql5Aa8VrWiiK8s6GcKUSdxb6HRcvsNfYBZiP78NYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPcNMve+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFB60A2601;
	Mon,  2 Nov 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPcNMve+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF791F00A1C;
	Mon,  2 Nov 2026 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618162;
	bh=TGJD+KdqvScwUJzjEuZa6O0XuHzgx+ke4p83StJ2m7Y=;
	h=From:To:Cc:Subject:Date;
	b=kPcNMve+2R8gWrtYDRWNWVuUnqWacV295GQL5gFoG4SVK8erH55rUdqV/jsBZzeAL
	 j0/7LlS2x62ePdG/qWatAxefsOXKTI28+sY4UOYuhhAeafdb1r2LEBbdVZOBVMlAmm
	 ouIG8Rwhw2PaUW3yMncmQibCLvA9O9Hr73W6A94oDqe0xnaosPCzSR1eYyZv/TPLoY
	 z3PulPlY8N6pwTdMIV7VfRRe+8GMm0lRPvljfOZgBLxhtvQKDE+M/AudC7kcWiIMVN
	 quXIYapy8bb3ar9+u2qIg3wUzw2HtR8P3wYwKSKpNETcNjumPHOJmXaXbZe2/aw7sY
	 dF8djxySOA34Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xNq1A-00000005aDu-0rMJ;
	Mon, 02 Nov 2026 12:16:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] driver core: platform: fix sw node use-after-free on device release
Date: Mon,  2 Nov 2026 12:14:18 +0100
Message-ID: <20261102111420.1330760-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko noted a new use-after-free issue when freeing platform device
which has a software node as its primary fw node.

Turns out that can cause trouble also when drivers or subsystems remove
software nodes themselves.

Johan


Johan Hovold (2):
  driver core: platform: fix sw node use-after-free on device release
  software node: fix primary software node removal

 drivers/base/platform.c | 3 ++-
 drivers/base/swnode.c   | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.55.0

