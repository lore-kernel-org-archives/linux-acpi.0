Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181944;
	b=5QpB4e6cpTEB/NY1Xa/JDpmujs+9zWmfL+2J/Igbjugsz2s9W4LnqVLTAPhkRRap5am8
	 pLbuAfUoUP/IskZ2WlIw9RrXMM1Q6IDczgg2G0/u5MFicdXFfm/Q4ScrFYMQJQd/IgJWi
	 i4s09n0MUHDLZTJk/ATeX6JkNXp481CCAZkgt/g7CLIrW6Md7Q6p50g4uJMgV+Gnr5XTL
	 orx1cYpeg3fZ3/TlK3xShlM7zXHmEl88SwbrUIgWDWwoscgff3HW7Z8fm9TDMQB49Gwg1
	 21ToXw4Df45txnRHaBN453tpNMvJXf4CYa/isb3R7Rw+pqGBjlxBDgZufvbTq94gNAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181944;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=GeZ/3S2tHCowDZLBYJkkB8e4OF2F66W+g0tF83qKxpU=;
	b=lBe6eQTuAsL+QIgFbfDUmoW01rAsuKs92ECgkUgD17DvnWbGyvUKg6aK7jFtPCrDOdJL
	 tdaANU7j4Hrz0lL32r4Y5pH9ajhQXCkWu0NyTH9ySMMzjze1k6Gyn2SDzEv9tFUky2XMk
	 RivC5oxyQdjUvdVQmCzo4nWEhZOrzru5Z5PRNF0irkcm8rglQZrOFw80BRpEe0F0ucU0w
	 0gKmNNqQ30C4/Ii3toNFXBE2UdwvR6YQub60xg0a/HkxKYqE41m9IfP1LL7tT4yp5AVUS
	 MGuwiYoDGPF9agME+RFnLcfajqJBl7UO6UPVm1GeYtCfb9qkM009NMqAZ13rXr89Eiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfDvHnmX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D4606A320;
	Fri, 20 Nov 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfDvHnmX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4851F000C6;
	Fri, 20 Nov 2026 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795181943;
	bh=GeZ/3S2tHCowDZLBYJkkB8e4OF2F66W+g0tF83qKxpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GfDvHnmXjRxI8zvjYyVz1tcdBT5D7TcxW6Wrt4VTPpnqyN8U/6QOaVGPZj36mwEON
	 yVT7x8ZL3FGA87o8lghn7nTvd4nPax280s4jEVKCpH/6jK0dJP3ckteUcnbrufr2SG
	 qF+qAnOh7xh0rhQET83mAeukSSgh80LY0mdkJwQZfiyXAM/loZcuuugeDjDwiecy6o
	 wq3LcVGBct7vn/PpgIZQgFJbq6S36i7p17clrAM7VXY5wCK1/jSQi2uQs+pQH7UOn7
	 +g/h/wcR4jHJSOOaB8RbQhbLRpmKroybD0F9j7UXNfYSkjCfwtu10x3bvQg/WYFSiR
	 NVGNtC6m4itpw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xUOpQ-0000000656E-3dHI;
	Fri, 20 Nov 2026 14:39:00 +0100
Date: Fri, 20 Nov 2026 14:39:00 +0100
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: fix node group deregistration kernel-doc
Message-ID: <awBNdNq3bYlhu7DY@hovoldconsulting.com>
References: <20261116103807.736778-1-johan@kernel.org>
 <CAJZ5v0jn32TL1N=PDY3v=9PL4ZJLainNUNN6ecXOJs=N0TSEjA@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jn32TL1N=PDY3v=9PL4ZJLainNUNN6ecXOJs=N0TSEjA@mail.gmail.com>

On Fri, Nov 20, 2026 at 02:18:24PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 16, 2026 at 11:38 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > Child software nodes hold a reference to their parent via kobj->parent
> > so there was never any need to deregister them in any particular order.
> >
> > Drop the misleading kernel-doc comments which suggest that deregistering
> > a parent node before a child could cause trouble.
> >
> > Note that parent nodes still need to be registered before their children
> > or registration will fail.
> >
> > Fixes: fc002f0f23e2 ("media: software_node: unregister software_nodes in reverse order")
> > Fixes: 0b8bf06f6719 ("device property: Sync descriptions of swnode array and group APIs")
> > Cc: Daniel Scally <djrscally@gmail.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> LGTM
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Applied for -next.

Johan
