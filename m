Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716700;
	b=Nql7gnDmHsX3YWota187uEUfVuHSeRvBRC6RB9CwdZLCCU7L6J95V2VQZ97pNLwzoGnP
	 Tw+LixpCM/spS9SxeLuOPdu4WiLJTYeK+qosX18+xqWkWBXC5lnhOLM060ZozYe0vqY9c
	 gDkUS/rPSKAoe+HSYmf6Fb+4aDbbLrKacWmjxLRyCKTLnqc6iKQ0Hj2v898InD0oU+KEA
	 X+ZQnsylxJsX7Uz3DYlKAHLc3KvToJucoymOJ3IPMQyM4/T40asMcwMjLZLXrSmcQX6vf
	 aG/p147v8Wg3H067bhzARZx62h//X+8w2xW2x8Zvqlo+ZLVL2E4V+GLXK/ohuhLmBUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716700;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ATFBiGGLJ6j4Bf1/ztZfgLS8UNvULPw9KJ8xxTWy52o=;
	b=fw0Ued4e7bxaO2Ndb6cjF3+D41DXmjwIjGvPM6+RvfBVEub2BfP1fZ9M48+2h/cSSNCU
	 94jnHZE9WHY6MR5z9rQ8rf09oQQAtYyc5aiDT0NAQwBmf6UlYp/b2IlrBowbsmDlvr8jL
	 f6RmfvaiHaqP+VqdOWQL7PTW9IXcue5L0rbMum2995pEnhw/1rBgrVJ3KBFhJrlMYB/X9
	 drfjuOQrBiD7+AjKe/J0GUVwGF5EJozmkjWSSNWY5YHbPplUiq9cT3OjmSwSQ4DPxRRwE
	 RsgzFVpMmuLubrRaj589p540CUFlWqTYUpuPa9C0DSBQU6sCEB+dYwQLkQjT7Rt75mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JR5No3V4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14DF606A326;
	Tue,  3 Nov 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JR5No3V4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6471F000C1;
	Tue,  3 Nov 2026 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716699;
	bh=ATFBiGGLJ6j4Bf1/ztZfgLS8UNvULPw9KJ8xxTWy52o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JR5No3V4dWQhddK0QnWaBXxFko/Ya92j5S2rJbLhCQKMr7CglSIQNQOz/EPTsM8+6
	 dvFt30wIuHAqFTQdSK4Oxli5YOYWVwCLswtcO1unkcEtGKEp2cpgabN8XdmA3H9xR4
	 aA4YM+R38zeKiOhHf18PFpCaM+5QLUfmamcbSj/OguX/MWmzPqhSB0MaGyK0FjIGH6
	 dkFb/wyifffy+8Mb+6XUUQukDifyqhC95ud4zY9lMB35QVXczrA3HkgyNuWrNuQKgk
	 RYzr6o+bfTQYpivT7cbVst5D61QUr5eGQaryihoak/TuWAUKdmHW/objRGQRgZ934N
	 SO7gCI8wQY5dg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xOFeS-00000006dfQ-34Ca;
	Tue, 03 Nov 2026 15:38:16 +0100
Date: Tue, 3 Nov 2026 15:38:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: fix sw node use-after-free on
 device release
Message-ID: <aunx2B_OgODKZdVw@hovoldconsulting.com>
References: <20261102111420.1330760-1-johan@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102111420.1330760-1-johan@kernel.org>

On Mon, Nov 02, 2026 at 12:14:18PM +0100, Johan Hovold wrote:
> Sashiko noted a new use-after-free issue when freeing platform device
> which has a software node as its primary fw node.
> 
> Turns out that can cause trouble also when drivers or subsystems remove
> software nodes themselves.

Hmm. The subtleties of the software node implementation got the better
of both the LLM and its operator it seems.

Clearing the secondary node when the device has only a software node
does indeed clear the fwnode pointer so there was never any UAF here.

I've dropped the first patch from the driver core testing branch.

Sorry for the noise.

Johan
